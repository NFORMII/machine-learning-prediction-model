from fastapi import FastAPI
from pydantic import BaseModel, Field
from starlette.middleware.cors import CORSMiddleware
import joblib
import numpy as np
import os

# Load the trained pipeline
pipeline = joblib.load("decision_tree_pipeline.pkl")

# Define input features
class BusinessFeatures(BaseModel):
    relationships: int = Field(..., ge=1, le=100, description="Number of business team members (1-100)")
    has_roundB: int = Field(..., ge=0, le=1, description="Has Series B funding (0 or 1)")
    funding_rounds: int = Field(..., ge=0, le=50, description="Number of funding rounds (0-50)")
    has_roundA: int = Field(..., ge=0, le=1, description="Has Series A funding (0 or 1)")
    has_roundC: int = Field(..., ge=0, le=1, description="Has Series C funding (0 or 1)")
    has_roundD: int = Field(..., ge=0, le=1, description="Has Series D funding (0 or 1)")
    funding_total_usd: int = Field(..., ge=0, description="Total funding in USD (>=0)")

# Create FastAPI app
app = FastAPI(
    title="Business Success Predictor API",
    description="Predict business success using funding and team features",
    version="1.0"
)

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Root endpoint
@app.get("/")
def root():
    return {"message": "Business Success Predictor API is running!"}

# Prediction endpoint
@app.post("/predict")
def predict_status(features: BusinessFeatures):
    data = np.array([[
        features.relationships,
        features.has_roundB,
        features.funding_rounds,
        features.has_roundA,
        features.has_roundC,
        features.has_roundD,
        features.funding_total_usd
    ]])
    raw_prediction = pipeline.predict(data)[0]
    predicted_class = 1 if raw_prediction >= 0.5 else 0

    return {
        "predicted_status": predicted_class,
        "raw_score": round(raw_prediction, 3)
    }

# Debug info to ensure docs are available
print("Swagger UI is available at /docs")

# Run Uvicorn if executed directly
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000))
    import uvicorn
    uvicorn.run("predict:app", host="0.0.0.0", port=port, reload=True)



# **Business Success Predictor**

 **Mission**

This project predicts the likelihood of a business succeeding based on team size, funding rounds, and total funding.
The goal is to help entrepreneurs and analysts estimate business potential using machine learning.
The solution includes a trained model, a FastAPI backend, and a Flutter mobile app.
Users can make real-time predictions via a public API and interactive mobile interface.

---

 **Demo Video:**

[https://youtu.be/3QhLr2lZNx8](https://youtu.be/3QhLr2lZNx8)

**GitHub Repository:**

[https://github.com/NFORMII/machine-learning-prediction-model.git](https://github.com/NFORMII/machine-learning-prediction-model.git)

**to test my api**

 https://machine-learning-prediction-model-3.onrender.com/docs
---

**to see if my api is up and running**
https://machine-learning-prediction-model-3.onrender.com

 **Dataset**

* **Source:** Crunchbase Startup Dataset (via Kaggle)
* **Description:** Contains business information such as funding rounds, total funding, and number of team relationships.
* **Rich Variety:** Includes Series A–D funding indicators, numerical team size, and multiple funding metrics.

### **Key Variables**

* `relationships` – Number of business team members
* `has_roundA`, `has_roundB`, `has_roundC`, `has_roundD` – Whether the business received Series A–D funding
* `funding_rounds` – Total number of funding rounds
* `funding_total_usd` – Total funding raised

### **Included Visualizations**

* Correlation heatmap
* Histograms and scatter plots for important variables

---

## **Model Training**

Three models were trained:

1. **Linear Regression**
2. **Decision Tree Regressor**
3. **Random Forest Regressor**

The model with the **lowest loss (Decision Tree)** was saved as:


decision_tree_pipeline.pkl


Example prediction test in Jupyter:

python
from predict import pipeline
import numpy as np

data = np.array([[10, 1, 3, 0, 1, 0, 500000]])
prediction = pipeline.predict(data)[0]
print(prediction)


## **API Documentation**

### **Base URL (Public)**

deplyed link

**https://machine-learning-prediction-model-2.onrender.com/**

### **Swagger UI**


**https://machine-learning-prediction-model-3.onrender.com/docs**

### **Endpoints**

#### **GET /**

Returns API status.

```json
{"message": "Business Success Predictor API is running!"}
```

#### **POST /predict**

Predicts whether a business will succeed.

Request example:

```json
{
  "relationships": 10,
  "has_roundB": 1,
  "funding_rounds": 3,
  "has_roundA": 0,
  "has_roundC": 1,
  "has_roundD": 0,
  "funding_total_usd": 500000
}
```

Response example:

```json
{
  "predicted_status": 1,
  "raw_score": 0.752
}
```

---

## **Mobile App (Flutter)**

The mobile app is connected directly to the FastAPI backend.
It contains:

* A prediction page
* Text fields for all input variables
* A “Predict” button
* Output display area

### **How to Run the Mobile App**

1. Install Flutter SDK
2. Navigate to the app folder:

   ```bash
   cd summative/mlprediction_app
   ```
3. Get dependencies:

   ```bash
   flutter pub get
   ```
4. Run on device/emulator:

   ```bash
   flutter run
   ```

---

## **How to Run the API Locally (Optional)**

```bash
cd summative/api

pip install -r requirements.txt
run python predict.py
```

Then open:
[https://machine-learning-prediction-model-3.onrender.com/docs](http://localhost:8000/docs)

---

## **Author**

Nformi Modestine Girbong


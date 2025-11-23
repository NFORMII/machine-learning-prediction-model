
# Business Success Predictor

## Project Overview

The **Business Success Predictor** is an API and mobile-ready solution to predict whether a business will succeed based on team size, funding rounds, and total funding. It leverages machine learning models including **Decision Trees**, **Random Forest**, and **Linear Regression** to make predictions.



## Dataset

* **Source:** [Insert dataset source here, e.g., Kaggle, Crunchbase]
* **Description:** The dataset contains business information including funding rounds, total funding, and team relationships.
* **Volume & Variety:** The dataset is rich, covering multiple funding stages (Series A-D), number of relationships, and total funding amounts.
* **Key Variables:**

  * `relationships`: Number of business team members (1-100)
  * `has_roundA`: Indicates if business has Series A funding (0 or 1)
  * `has_roundB`: Indicates if business has Series B funding (0 or 1)
  * `has_roundC`: Indicates if business has Series C funding (0 or 1)
  * `has_roundD`: Indicates if business has Series D funding (0 or 1)
  * `funding_rounds`: Total number of funding rounds (0-50)
  * `funding_total_usd`: Total funding in USD (>=0)

### Visualizations

* **Correlation Heatmap:** Shows relationships between funding rounds, team size, and funding total.
* **Variable Distributions:** Histograms and scatter plots for key variables affecting model outcomes.



## Models

The project includes the following models:

1. **Decision Tree Regressor**
2. **Random Forest Regressor**
3. **Linear Regression**

* The model with the **lowest loss** is saved (`decision_tree_pipeline.pkl`) and used for predictions.
* Example of predicting a single business:

```python
from predict import pipeline
import numpy as np

data = np.array([[10, 1, 3, 0, 1, 0, 500000]])
prediction = pipeline.predict(data)[0]
print(prediction)
```



## API

### FastAPI Endpoints

* **Base URL:** `http://localhost:8000`
* **Swagger UI:** `http://localhost:8000/docs`

### Endpoints

1. **GET /**

   * Description: Returns a simple message confirming the API is running.
   * Response:

   ```json
   {"message": "Business Success Predictor API is running!"}
   ```

2. **POST /predict**

   * Description: Predicts whether a business will succeed.
   * Request Body:

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

   * Response:

   ```json
   {
       "predicted_status": 1,
       "raw_score": 0.752
   }
   ```



## Mobile App Integration

* The API is designed for mobile apps to send feature inputs and receive predictions.
* Mobile app interface includes:

  * Text inputs for each feature
  * Submit button
  * Output display for predicted status



## Installation

1. Clone the repo:

```bash
git clone <your-repo-url>
cd business-success-predictor
```

2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Run the API:

```bash
uvicorn predict:app --reload
```

4. Open Swagger UI at `http://localhost:8000/docs` to test predictions.

-

Author

Nformi Modestine Girbong





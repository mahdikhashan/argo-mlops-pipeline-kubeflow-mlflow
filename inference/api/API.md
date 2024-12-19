REST API Specification
---

### Healthcheck Endpoint

- **URL**: `/healthcheck`
- **Method**: `GET`
- **Description**: Checks the health status of the application.
- **Response**:
    - **200 OK**: The application is healthy.

---

### Predict Endpoint

- **URL**: `/predict`
- **Method**: `POST`
- **Description**: Predicts the digit in the uploaded image using a trained model.
- **Request Body**:
    - **file**: A file containing the image to be predicted (must be in `.png`, `.jpg`, or `.jpeg` format).
- **Response**:
    - **200 OK**: The predicted digit.
        - **Content**: JSON object containing the predicted digit.
      ```json
      {
        "predicted_digit": <digit>
      }
      ```
    - **400 Bad Request**: If the image file is not provided or is invalid.

---

### Notes
- The model is loaded from MLflow with the URI `"models:/mnist_mlp/latest"`.
- The app uses `torch` for model inference and processes the image by resizing it to 28x28 pixels and flattening it.
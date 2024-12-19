import os
import io
from PIL import Image

from flask import Flask, jsonify, request
from healthcheck import HealthCheck

app: Flask = Flask(__name__)

health = HealthCheck()
app.add_url_rule("/healthcheck", "healthcheck", view_func=lambda: health.run())

import torch

assert torch.__version__ >= "2.3.0"
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

import mlflow
import mlflow.pytorch

assert mlflow.__version__ >= "1.0.0"
mlflow.set_tracking_uri(os.getenv("MLFLOW_TRACKING_URI"))

import torchvision.transforms as transforms


def preprocess_image(image):
    transform = transforms.Compose(
        [
            transforms.Resize((28, 28)),
            transforms.ToTensor(),
        ]
    )
    image_resized = transform(image)
    flat = torch.flatten(image_resized, start_dim=1)
    return flat


# TODO: capture exceptions for file
@app.route("/predict", methods=["POST"])
def predict():
    if request.method == "POST":
        file = request.files["file"]
        img = Image.open(io.BytesIO(file.read()))

        # TODO: it could be passed from env
        model_uri = "models:/mnist_mlp/latest"
        model = mlflow.pytorch.load_model(model_uri)
        model = model.to(device)

        model.eval()

        inputs = preprocess_image(img)

        with torch.no_grad():
            output = model(inputs)

        predicted_digit = torch.argmax(output, dim=1).item()

        app.logger.info("predicted in successfully: %s", predicted_digit)

        return jsonify(predicted_digit)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)

import io
from PIL import Image

from flask import Flask, jsonify, request

app: Flask = Flask(__name__)

import torch

assert torch.__version__ >= "2.0.0"
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

import mlflow
import mlflow.pytorch

assert mlflow.__version__ >= "1.0.0"
mlflow.set_tracking_uri("http://127.0.0.1:8090/")

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


@app.route("/predict", methods=["POST"])
def predict():
    if request.method == "POST":
        file = request.files["file"]
        img = Image.open(io.BytesIO(file.read()))

        model_uri = "models:/mnist_mlp/latest"
        model = mlflow.pytorch.load_model(model_uri)
        model = model.to(device)

        model.eval()

        inputs = preprocess_image(img)

        with torch.no_grad():
            output = model(inputs)

        predicted_digit = torch.argmax(output, dim=1).item()

        print(predicted_digit)

        return jsonify(predicted_digit)

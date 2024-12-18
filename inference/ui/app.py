import requests

import streamlit
assert streamlit.__version__ >= "1.38.0"

from streamlit_drawable_canvas import st_canvas

import cv2

SERVING_URL = "http://localhost:5003/predict"

streamlit.title('MNIST Inference')
streamlit.markdown('''
Try to write a digit!
''')

option = streamlit.selectbox(
    "Select Model:",
    ("Email", "Home phone", "Mobile phone"),
    index=None,
    placeholder="Select contact method...",
)

SIZE = 192
img = None
model = None

mode = streamlit.checkbox("Draw (or Delete)?", True)

canvas_result = st_canvas(
    fill_color='#000000',
    stroke_width=15,
    stroke_color='#FFFFFF',
    background_color='#000000',
    width=SIZE,
    height=SIZE,
    drawing_mode="freedraw" if mode else "transform",
    key='canvas')

if canvas_result.image_data is not None:
    img = cv2.resize(canvas_result.image_data.astype('uint8'), (28, 28))
    rescaled = cv2.resize(img, (SIZE, SIZE), interpolation=cv2.INTER_NEAREST)
    streamlit.write('Model Input')
    streamlit.image(rescaled) # Clamp=True

if streamlit.button('Predict'):
    test_x = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    _, img_encoded = cv2.imencode('.png', test_x)
    img_bytes = img_encoded.tobytes()

    try:
        resp = requests.post(
            SERVING_URL,
            files={"file": ("image.png", img_bytes, "image/png")}
        )

        if resp.status_code == 200:
            streamlit.write(f"Result: {resp.json()}")
        else:
            streamlit.write("Error in prediction response:", resp.status_code)
    except Exception as e:
        streamlit.error(f"Request failed: {e}")

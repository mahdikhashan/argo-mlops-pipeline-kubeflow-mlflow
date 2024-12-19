FROM python:3.11-slim
LABEL authors="mahdikhashan"

WORKDIR /app
COPY . /app/

RUN apt-get update && apt-get install libgl1 -y

RUN pip3 install -r requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]

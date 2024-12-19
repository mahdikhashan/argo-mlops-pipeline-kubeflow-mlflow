FROM python:3.11-slim
LABEL authors="mahdikhashan"

WORKDIR /app
COPY . /app/

RUN apt-get update

RUN pip3 install -r requirements.txt

EXPOSE 8000

HEALTHCHECK CMD curl --fail http://localhost:8000/healthcheck

ENTRYPOINT ["python3"]

CMD ["app.py"]

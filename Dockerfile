FROM python:3-alpine
LABEL author="Dragana Stamenkovikj"

WORKDIR /usr/src/app

COPY requirements.txt app.py /usr/src/app/ 
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3000

ENTRYPOINT ["python", "app.py"]
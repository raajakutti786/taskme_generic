FROM python:3.8-slim-buster

RUN mkdir app

WORKDIR /app

#COPY requirements.txt requirements.txt

COPY . .

RUN pip3 install -r requirements.txt

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]





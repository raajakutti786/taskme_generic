from flask import Flask, request, render_template
import requests
from helloworld import responseconcat
import json

app = Flask(__name__)


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/dbsave', methods = ['POST'])
def dbsave():
    #response = requests.get(url="http://localhost:3000/dbsave")
    name = request.form["name"]
    value = request.form["value"]

    inputvalues = {
        "name": str(name), 
        "value": str(value)
    }

    response = requests.post(url="http://localhost:3000/dbsave", data=json.dumps(inputvalues))
    return str(responseconcat(response.text))


if __name__ == '__main__':
    app.run(host="localhost", port=5000, debug=True)

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello(): 
    return "Hello World"

@app.route("/upload_data"):
def upload_data():
    return "not implemented"

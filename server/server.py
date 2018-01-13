from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello(): 
    return "Hello World"

@app.route("/upload_data", methods=["GET"]):
def upload_data():
    data = request.data
    print data # for now 

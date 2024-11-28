# app.py (Frontend)
from flask import Flask, render_template
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app) # This will enable CORS for all routes

@app.route('/')
def index():
    response = requests.get('http://127.0.0.1:5001/users')  # Connect to local backend webapi.py
    
    data = response.json()

    return render_template('index.html', data=data) # Connect to local frontend index.html

if __name__ == '__main__':
    app.run(port=5000, debug=True)
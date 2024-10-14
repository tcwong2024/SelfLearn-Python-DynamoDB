# app.py (Frontend)
from flask import Flask, render_template
import requests

app = Flask(__name__)

@app.route('/')
def index():
    # response = requests.get('http://127.0.0.1:5001/api/data')  # Connect to local backend
    response = requests.get('http://127.0.0.1:5001/users')  # Connect to local backend
    data = response.json()
    return render_template('index.html', data=data)

if __name__ == '__main__':
    app.run(port=5000, debug=True)
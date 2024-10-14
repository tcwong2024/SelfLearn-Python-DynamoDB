# api.py (Backend)
from flask import Flask, jsonify
import boto3

app = Flask(__name__)
dynamodb = boto3.resource('dynamodb', region_name='us-east-1', endpoint_url='http://localhost:8000')

@app.route('/api/data', methods=['GET'])
def get_data():
    table = dynamodb.Table('MyTable')
    response = table.scan()
    items = response['Items']
    return jsonify(items)

if __name__ == '__main__':
    app.run(port=5001, debug=True)

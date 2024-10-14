from flask import Flask, jsonify, request
from flask_cors import CORS  # Import CORS
import boto3
from botocore.exceptions import ClientError

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Initialize DynamoDB
dynamodb = boto3.resource('dynamodb', region_name='us-east-1', endpoint_url='http://localhost:8000')
table = dynamodb.Table('MyTable')

# List users
@app.route('/users', methods=['GET'])
def list_users():
    try:
        response = table.scan()
        return jsonify(response['Items'])
    except ClientError as e:
        return jsonify({'error': str(e)}), 500

# Create a new user
@app.route('/users', methods=['POST'])
def create_user():
    data = request.json
    try:
        table.put_item(Item={
            'Id': data['Id'],
            'Name': data['Name'],
            'Age': int(data['Age']),
            'City': data['City']
        })
        return jsonify({'message': 'User created successfully!'}), 201
    except ClientError as e:
        return jsonify({'error': str(e)}), 500

# Edit an existing user
@app.route('/users/<string:id>', methods=['PUT'])
def update_user(id):
    data = request.json
    try:
        table.update_item(
            Key={'Id': id},
            # UpdateExpression="set Name=:n, Age=:a, City=:c",
            UpdateExpression="SET #n = :n, Age = :a, City = :c",
            ExpressionAttributeNames={
                '#n': 'Name'  # Use a placeholder for the reserved keyword
            },
            ExpressionAttributeValues={
                ':n': data['Name'],
                ':a': int(data['Age']),
                ':c': data['City']
            },
            ReturnValues="UPDATED_NEW"
        )
        return jsonify({'message': 'User updated successfully!'})
    except ClientError as e:
        return jsonify({'error': str(e)}), 500

# Delete a user
@app.route('/users/<string:id>', methods=['DELETE'])
def delete_user(id):
    try:
        table.delete_item(Key={'Id': id})
        return jsonify({'message': 'User deleted successfully!'})
    except ClientError as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    # app.run(debug=True)
    app.run(port=5001, debug=True)
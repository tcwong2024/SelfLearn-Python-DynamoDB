import boto3

# Initialize the DynamoDB client
dynamodb = boto3.resource('dynamodb', region_name='us-east-1', endpoint_url='http://localhost:8000')  # Update with your region

# Select the table
table = dynamodb.Table('MyTable')

# Define the item to insert (change attributes according to your table schema)
item = {
    'Id': '003',  # Replace 'PrimaryKey' with your actual partition key
    'Name': 'Chin Foong',
    'Age': 10,
    'City': 'Singapore'
}

# Add the item to the table
response = table.put_item(Item=item)

# Print response to confirm success
print("Item inserted successfully:", response)
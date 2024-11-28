import boto3

# Initialize the DynamoDB client
dynamodb = boto3.resource('dynamodb', region_name='us-east-1', endpoint_url='http://localhost:8000')  # Update with your region

# Select the table
table = dynamodb.Table('MyTable')

# List of items to insert
items = [
    {'Id': '001', 'Name': 'James Bond', 'Age': 21, 'City': 'Sydney'},
    {'Id': '002', 'Name': 'John Rambo', 'Age': 21, 'City': 'New York'},
    {'Id': '003', 'Name': 'Indiana Jones', 'Age': 21, 'City': 'London'},
    {'Id': '004', 'Name': 'Steve Rogers', 'Age': 21, 'City': 'Taipei'},
    {'Id': '005', 'Name': 'Arnold Schwarzenegger', 'Age': 21, 'City': 'Tokyo'}
]

# Batch write operation
inserted_items = []  # Keep track of successfully inserted items
with table.batch_writer() as batch:
    for item in items:
        batch.put_item(Item=item)   # Insert into table
        inserted_items.append(item)  # Add to the list of inserted items
        
# Print records to confirm success
print("Item inserted successfully: ")
for record in inserted_items:
    print(record)
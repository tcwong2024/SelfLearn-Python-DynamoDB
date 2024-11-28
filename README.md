# Learn Python to create Rest API with DynamoDB

## Setup requirement tools
1. Check software version
   ```
      python3 -V
      java --version
      pip show Flask flask-cors boto3 requests 
   ```

## Setup DynamoDb locally
1. Download DynamoDb local from below link, Extract into folder.
   ```
      https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html
   ``` 

2. Locate to the extract folder, use WSL to run the command
   ```
      java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
   ```

3. Use this command to check DynamoDb running
   ```
      aws dynamodb list-tables --endpoint-url http://localhost:8000
   ```

4. Create dynamodb table
   ```
      aws dynamodb create-table \
         --table-name MyTable \
         --attribute-definitions AttributeName=Id,AttributeType=S \
         --key-schema AttributeName=Id,KeyType=HASH \
         --billing-mode PAY_PER_REQUEST \
         --endpoint-url http://localhost:8000
         --region us-east-1
   ```

5. Describe dynamodb table
   ```
      aws dynamodb describe-table \
         --table-name MyTable \
         --endpoint-url http://localhost:8000
   ```

6. Insert records
   ```
      aws dynamodb put-item \
         --table-name MyTable \
         --item '{"Id": {"S": "001"}, "Name": {"S": "James Bond"}, "Age": {"N": "21"}, "City": {"S": "Sydney"}}' \
         --endpoint-url http://localhost:8000
   ```

7. View dynamodb records
   ```
      aws dynamodb scan --table-name MyTable --endpoint-url http://localhost:8000
   ```

## Build Web Application (Front-End)

- Create webapp.py 
- Call webapi to get the all users lists.
- Render all data into index.html

## Build Web API (Back-End)

- Create webapi.py
- Connect to dynamodb table
- Get all records from table
- Return json format as response

# Test run
```
   cd db
   java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb

   python3 webapp.py

   python3 webapi.py

   python3 insert_record.py

   launch at http://localhost:5000/
```
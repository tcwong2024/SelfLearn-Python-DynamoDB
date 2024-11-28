## Learn how to create rest API (CRUD) using Python with DynamoDb

### You need to install the following tools locally:
-	**Python**: For your web and backend applications.
-	**Java Runtime Environment**: for local DynamoDB use.
-	**Flask or Django**: For building the web frontend and API backend.
-	**Boto3**: AWS SDK for Python to interact with DynamoDB.
-	**Local DynamoDB**: Amazon provides a downloadable DynamoDB that you can run locally.

### Check software version
1. Check python version
   ```
      python3 -V
   ```
2. Chekc Java Runtime Environment
   ```
      java --version
   ```
3. Check library for python 
   ```
      pip show Flask flask-cors boto3 requests
   ```
   
### Setup local DynamoDb 
1. Download local DynamoDb from below link, extract the zip file into "db" folder.
   ```
      https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html
   ``` 

2. Locate to the "db" folder and run below command to start local dynamoDb at port **8000**
   ```
      java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
   ```

3. Use below aws command to check tables in DynamoDb instances
   ```
      aws dynamodb list-tables --endpoint-url http://localhost:8000
   ```

4. Use below aws command to create dynamodb table
   ```
      aws dynamodb create-table \
         --table-name MyTable \
         --attribute-definitions AttributeName=Id,AttributeType=S \
         --key-schema AttributeName=Id,KeyType=HASH \
         --billing-mode PAY_PER_REQUEST \
         --endpoint-url http://localhost:8000
         --region us-east-1
   ```

5. Use below aws command to describe dynamodb table
   ```
      aws dynamodb describe-table \
         --table-name MyTable \
         --endpoint-url http://localhost:8000
   ```

6. Use below aws command to insert records into dynamoDb table
   ```
      aws dynamodb put-item \
         --table-name MyTable \
         --item '{"Id": {"S": "001"}, "Name": {"S": "James Bond"}, "Age": {"N": "21"}, "City": {"S": "Sydney"}}' \
         --endpoint-url http://localhost:8000
   ```

7. Use below aws command to view DynamoDb table records
   ```
      aws dynamodb scan --table-name MyTable --endpoint-url http://localhost:8000
   ```

### Build Web Application (Front-End)
- Create **index.html**,  this is the main web page contain all html tag and rendering data.
- Create **webapp.py**, this python file use to call **webapi.py** to get data from tables and pass it to **index.html** for rendering. 

### Build Web API (Back-End)
- Create **webapi.py**
- This python file connecting to DynamoDb table and get records from table.
- It will return **json** format as response.

### How to test run loccally.
1. Activate the DynamoDb (port **8000**)
   ```
      cd db
      java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
   ```
2. Run below command in Terminal, to insert sample records into DynamoDb table.
   ```
      python3 insert_record.py
   ```
3. Open new Terminal and run below command to launch web application (port **5000**)
   ```
      python3 webapp.py
   ```
4. Open new Terminal and run below command to launch web API (port **5001**)
   ```
      python3 webapi.py
   ```
5. Open browser and enter below url or use terminal curl command.
   ```
      http://localhost:5000/
   ```

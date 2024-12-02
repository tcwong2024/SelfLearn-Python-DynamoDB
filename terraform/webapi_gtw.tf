# # ----------------------------------------------------------------------------------------------------
# # Rest API Gateway - usieng GET, POST, PUT, DELETE 
# # ----------------------------------------------------------------------------------------------------

# Define the API Gateway REST API with regional endpoint type
resource "aws_api_gateway_rest_api" "jokes_api" {
  name        = var.rest_api_name
  description = var.rest_api_description

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# # ----------------------------------------------------------------------------------------------------
# # Define Resources
# # ----------------------------------------------------------------------------------------------------

# Create the resource for 'jokes' path
resource "aws_api_gateway_resource" "jokes_resource" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  parent_id   = aws_api_gateway_rest_api.jokes_api.root_resource_id
  path_part   = "jokes"
}

# Sub-resource: /jokes/{Id}
resource "aws_api_gateway_resource" "jokes_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  parent_id   = aws_api_gateway_resource.jokes_resource.id
  path_part   = "{Id}"
}

# # ----------------------------------------------------------------------------------------------------
# # Lambda permission
# # ----------------------------------------------------------------------------------------------------

# Lambda permission to allow API Gateway to invoke Lambda
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.jokes_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.jokes_api.execution_arn}/*/*"
}

# # ----------------------------------------------------------------------------------------------------
# # Define Methods - /jokes
# # ----------------------------------------------------------------------------------------------------

# Define the GET method
resource "aws_api_gateway_method" "get_jokes" {
  rest_api_id   = aws_api_gateway_rest_api.jokes_api.id
  resource_id   = aws_api_gateway_resource.jokes_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Define the POST method
resource "aws_api_gateway_method" "post_jokes" {
  rest_api_id   = aws_api_gateway_rest_api.jokes_api.id
  resource_id   = aws_api_gateway_resource.jokes_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# Define the OPTIONS method
resource "aws_api_gateway_method" "options_cors" {
  rest_api_id   = aws_api_gateway_rest_api.jokes_api.id
  resource_id   = aws_api_gateway_resource.jokes_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# # ----------------------------------------------------------------------------------------------------
# # Define Methods - /jokes/{Id}
# # ----------------------------------------------------------------------------------------------------

# Define a PUT method for /jokes/{id}
resource "aws_api_gateway_method" "put_joke_by_id" {
  rest_api_id   = aws_api_gateway_rest_api.jokes_api.id
  resource_id   = aws_api_gateway_resource.jokes_id_resource.id
  http_method   = "PUT"
  authorization = "NONE"

  # Define the path parameter 'Id'
  request_parameters = {
    "method.request.path.Id" = true
  }
}

# Define a DELETE method for /jokes/{id}
resource "aws_api_gateway_method" "delete_joke_by_id" {
  rest_api_id   = aws_api_gateway_rest_api.jokes_api.id
  resource_id   = aws_api_gateway_resource.jokes_id_resource.id
  http_method   = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "options_joke_by_id" {
  rest_api_id   = aws_api_gateway_rest_api.jokes_api.id
  resource_id   = aws_api_gateway_resource.jokes_id_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# # ----------------------------------------------------------------------------------------------------
# # Add Methods response - /jokes
# # ----------------------------------------------------------------------------------------------------

resource "aws_api_gateway_method_response" "get_method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_resource.id
  http_method = aws_api_gateway_method.get_jokes.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "post_method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_resource.id
  http_method = aws_api_gateway_method.post_jokes.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "option_cors_method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_resource.id
  http_method = aws_api_gateway_method.options_cors.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

# # ----------------------------------------------------------------------------------------------------
# # Add Methods response - \jokes\{Id}
# # ----------------------------------------------------------------------------------------------------

resource "aws_api_gateway_method_response" "put_joke_by_id_response" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_id_resource.id
  http_method = aws_api_gateway_method.put_joke_by_id.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "delete_joke_by_id_response" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_id_resource.id
  http_method = aws_api_gateway_method.delete_joke_by_id.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_method_response" "options_joke_by_id_response" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_id_resource.id
  http_method = aws_api_gateway_method.options_joke_by_id.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

# # ----------------------------------------------------------------------------------------------------
# # Setup up Integration - \jokes
# # ----------------------------------------------------------------------------------------------------

# Integrate GET method with Lambda
resource "aws_api_gateway_integration" "get_jokes_integration" {
  rest_api_id             = aws_api_gateway_rest_api.jokes_api.id
  resource_id             = aws_api_gateway_resource.jokes_resource.id
  http_method             = aws_api_gateway_method.get_jokes.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.jokes_lambda.invoke_arn

}

# Integrate POST method with Lambda
resource "aws_api_gateway_integration" "post_jokes_integration" {
  rest_api_id             = aws_api_gateway_rest_api.jokes_api.id
  resource_id             = aws_api_gateway_resource.jokes_resource.id
  http_method             = aws_api_gateway_method.post_jokes.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.jokes_lambda.invoke_arn
}

# Integrate OPTIONS method with Lambda
resource "aws_api_gateway_integration" "options_cors_integration" {
  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_resource.id
  http_method = aws_api_gateway_method.options_cors.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

# # ----------------------------------------------------------------------------------------------------
# # Setup up Integration - \jokes\{Id}
# # ----------------------------------------------------------------------------------------------------

resource "aws_api_gateway_integration" "put_joke_by_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.jokes_api.id
  resource_id             = aws_api_gateway_resource.jokes_id_resource.id
  http_method             = aws_api_gateway_method.put_joke_by_id.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.jokes_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "delete_joke_by_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.jokes_api.id
  resource_id             = aws_api_gateway_resource.jokes_id_resource.id
  http_method             = aws_api_gateway_method.delete_joke_by_id.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.jokes_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "options_joke_by_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.jokes_api.id
  resource_id             = aws_api_gateway_resource.jokes_id_resource.id
  http_method             = aws_api_gateway_method.options_joke_by_id.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

# # ----------------------------------------------------------------------------------------------------
# # Define Integration responses - \jokes
# # ----------------------------------------------------------------------------------------------------

resource "aws_api_gateway_integration_response" "get_jokes_integration_response" {

  depends_on = [
    aws_api_gateway_integration.get_jokes_integration, # update 20241202
    aws_api_gateway_method_response.get_method_response_200
  ]

  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_resource.id
  http_method = aws_api_gateway_method.get_jokes.http_method
  status_code = "200"

  response_templates = {
    "application/json" = ""
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_integration_response" "post_jokes_integration_response" {
  depends_on = [
    aws_api_gateway_integration.post_jokes_integration, # update 20241202
    aws_api_gateway_method_response.post_method_response_200
  ]

  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_resource.id
  http_method = aws_api_gateway_method.post_jokes.http_method
  status_code = "200"

  response_templates = {
    "application/json" = ""
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_integration_response" "option_cors_integration_response" {
  depends_on = [
    aws_api_gateway_integration.options_cors_integration,
    aws_api_gateway_method_response.option_cors_method_response_200
  ]

  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_resource.id
  http_method = aws_api_gateway_method.options_cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET, OPTIONS, POST'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }
}

# # ----------------------------------------------------------------------------------------------------
# # Define Integration responses - \jokes\{Id}
# # ----------------------------------------------------------------------------------------------------

resource "aws_api_gateway_integration_response" "put_joke_by_id_integration_response" {

  depends_on = [
    aws_api_gateway_integration.put_joke_by_id_integration, # update 20241202
    aws_api_gateway_method_response.put_joke_by_id_response
  ]

  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_id_resource.id
  http_method = aws_api_gateway_method.put_joke_by_id.http_method
  status_code = "200"

  response_templates = {
    "application/json" = "$input.json('$.body')" # Map the 'body' field from the backend response.
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_integration_response" "delete_joke_by_id_integration_response" {

  depends_on = [
    aws_api_gateway_integration.delete_joke_by_id_integration, # update 20241202
    aws_api_gateway_method_response.delete_joke_by_id_response
  ]

  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_id_resource.id
  http_method = aws_api_gateway_method.delete_joke_by_id.http_method
  status_code = "200"

  response_templates = {
    "application/json" = ""
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_integration_response" "options_joke_by_id_integration_response" {
  depends_on = [
    aws_api_gateway_integration.options_joke_by_id_integration, # update 20241202
    aws_api_gateway_method_response.options_joke_by_id_response
  ]

  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
  resource_id = aws_api_gateway_resource.jokes_id_resource.id
  http_method = aws_api_gateway_method.options_joke_by_id.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS, PUT, DELETE'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }

  response_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

# # ----------------------------------------------------------------------------------------------------
# # Deployment the API
# # ----------------------------------------------------------------------------------------------------

# Deployment for the API Gateway
resource "aws_api_gateway_deployment" "jokes_deployment" {
  depends_on = [
    aws_api_gateway_resource.jokes_resource,
    aws_api_gateway_resource.jokes_id_resource,
    aws_api_gateway_method.get_jokes,
    aws_api_gateway_method.post_jokes,
    aws_api_gateway_method.options_cors,
    aws_api_gateway_method.put_joke_by_id,
    aws_api_gateway_method.delete_joke_by_id,
    aws_api_gateway_method.options_joke_by_id,
    aws_api_gateway_method_response.get_method_response_200,
    aws_api_gateway_method_response.post_method_response_200,
    aws_api_gateway_method_response.option_cors_method_response_200,
    aws_api_gateway_method_response.put_joke_by_id_response,
    aws_api_gateway_method_response.delete_joke_by_id_response,
    aws_api_gateway_method_response.options_joke_by_id_response,
    aws_api_gateway_integration.get_jokes_integration,
    aws_api_gateway_integration.post_jokes_integration,
    aws_api_gateway_integration.options_cors_integration,
    aws_api_gateway_integration.put_joke_by_id_integration,
    aws_api_gateway_integration.delete_joke_by_id_integration,
    aws_api_gateway_integration.options_joke_by_id_integration,
    aws_api_gateway_integration_response.get_jokes_integration_response,
    aws_api_gateway_integration_response.post_jokes_integration_response,
    aws_api_gateway_integration_response.option_cors_integration_response,
    aws_api_gateway_integration_response.put_joke_by_id_integration_response,
    aws_api_gateway_integration_response.delete_joke_by_id_integration_response,
    aws_api_gateway_integration_response.options_joke_by_id_integration_response
  ]

  rest_api_id = aws_api_gateway_rest_api.jokes_api.id
}

# # ----------------------------------------------------------------------------------------------------
# # Stage Resource # added at 20241202
# # ----------------------------------------------------------------------------------------------------

resource "aws_api_gateway_stage" "api_stage" {
  rest_api_id   = aws_api_gateway_rest_api.jokes_api.id
  deployment_id = aws_api_gateway_deployment.jokes_deployment.id
  stage_name    = var.stage_name
  description   = var.stage_name_desc
}

# # ----------------------------------------------------------------------------------------------------

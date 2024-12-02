# ---------------------------------------------------
# For Dynamodb 
# ---------------------------------------------------
variable "dynamodb_table_name" {
  description = "dynamodb table name"
  type        = string
  default     = "ce7-grp-2-jokes-db"
}

# ---------------------------------------------------
# For Lambda function
# ---------------------------------------------------
variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
  default     = "ce7-grp-2-jokes-lambda"
}

variable "python_version" {
  description = "Python version"
  type        = string
  default     = "python3.13"
}

# ---------------------------------------------------
# For IAM
# ---------------------------------------------------
variable "jokes_execution_role_name" {
  description = "Jokes execution role name"
  type        = string
  default     = "ce7-grp-2-jokes-execution-role"
}

variable "jokes_policy_name" {
  description = "Jokes policy name"
  type        = string
  default     = "ce7-grp-2-jokes-policy"
}

# ---------------------------------------------------
# For API GAteway
# ---------------------------------------------------

variable "rest_api_name" {
  description = "Rest API name"
  type        = string
  default     = "ce7-grp-2-jokes-restapi"
}

variable "rest_api_description" {
  description = "Rest API description"
  type        = string
  default     = "REST API to invoke lambda function for managing DynamoDB tables."
}

variable "stage_name" {
  description = "Stage name"
  type        = string
  default     = "dev"
}

variable "stage_name_desc" {
  description = "Stage name description"
  type        = string
  default     = "Development stage"
}

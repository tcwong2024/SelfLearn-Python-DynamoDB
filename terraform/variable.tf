variable "dynamodb_table_name" {
  description = "dynamodb table name"
  type        = string
  default     = "ce7-grp-2-jokesdb"
}

variable "lambda_function_name" {
  description = "lambda dunction name"
  type        = string
  default     = "ce7-grp-2-jokes-lambda"
}

# variable "lambda_function_zip_name" {
#   description = "lambda dunction name"
#   type        = string
#   default     = "ce7-grp-2-jokes-lambda.zip"
# }
resource "aws_dynamodb_table" "jokes_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "Id"
    type = "N" # Numeric type for the primary key
  }

  hash_key = "Id" # Define the primary key

  tags = {
    Environment = "dev"
    Team        = "group-2"
  }
}

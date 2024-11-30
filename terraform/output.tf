output "api-gateway-url" {

  value = aws_api_gateway_deployment.jokes_deployment.invoke_url

}

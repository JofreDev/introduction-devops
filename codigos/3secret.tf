
### Describe el secreto que se va a crear
resource "aws_secretsmanager_secret" "dockerhubconnection" {
  kms_key_id   ="arn:aws:kms:us-east-1:561607169148:key/cbce96c0-d496-4265-9db7-08db0a113109"
  name          = "dockerhub-connection"
  description = "Master password for docker hub"
}

## Define especificamente los secretos 
### ¿ De qué es la imagen ? ## Se especifica en el codebuild. 
resource "aws_secretsmanager_secret_version" "dockerhubconnection" {
  secret_id = aws_secretsmanager_secret.dockerhubconnection.id
  secret_string = jsonencode({
    Username = "jaivic"
    Password = "Jaivic123."
  })
}
### Acá va al source para implementar la imagen o código que se le pase

### Construcción del terraform

### Plan

resource "aws_codebuild_project" "plan" {
  name          = "cicd-plan"
  description   = "Plan stage for terraform"
  service_role  = aws_iam_role.assume_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  ### Configurando codebuild para usar una imagen de terraform !!!!

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:0.14.3" ## Se define la imagen q va a usar. 
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential{
        credential = aws_secretsmanager_secret.dockerhubconnection.arn
        credential_provider = "SECRETS_MANAGER" ## Credenciales para accerder a docker hub  
    }
 }
 source {
     type   = "CODEPIPELINE"
     buildspec = file("buildspec/plan-buildspec.yml") ##Le especifico los comandos a ejecutar para construir terraform
 }
}

resource "aws_codebuild_project" "apply" {
  name          = "cicd-apply"
  description   = "Apply stage for terraform"
  service_role  = aws_iam_role.assume_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:0.14.3"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential{
        credential = aws_secretsmanager_secret.dockerhubconnection.arn
        credential_provider = "SECRETS_MANAGER"
    }
 }
 source {
     type   = "CODEPIPELINE"
     buildspec = file("buildspec/apply-buildspec.yml")
 }
}


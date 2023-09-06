## Bucket para que codepipeline almacene sus artefactos

resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = "practicas-mis-despliegues-automaticos-con-terraform"
}

## Tf necesita otro bucket para almacenar sus ficheros cuando ya esté funcionando.

resource "aws_s3_bucket" "terraformstate" {
  bucket = "practicas-terraform-state"
} 

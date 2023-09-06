resource "aws_codecommit_repository" "cicd-code" {
  repository_name = "repositorio-de-cicd" ## Nombre del repo
  description     = "Es donde se va a alojar la infra de todoo loq ue vamos a hacer con terraform"
}
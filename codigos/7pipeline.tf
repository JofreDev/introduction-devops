
# Orquestador encargado de unir el code commit con los codebuild.

resource "aws_codepipeline" "cicd_pipeline" {
  name     = "terraform-cicd" # Importante el nombre
  role_arn = aws_iam_role.assume_codepipeline_role.arn # Se agrega el rol

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_artifacts.id ## Se llama al bucket donde almacenará sus archivos
  }
  stage { ### El code pipeline usará un CodeCommit
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["code"]
      configuration = {
        RepositoryName       = "repositorio-de-cicd" ## Le decimos que repo usará (Que se creo en 1codecommit)
        BranchName           = "master"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage { ### El code pipeline usará un CodeBuild
    name = "Plan"
    action {
      name            = "Build"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["code"]
      configuration = {
        ProjectName = "cicd-plan"  ## Le decimos que proyecto usará (Que se creo en 6codebuild)
      }
    }
  }

  stage { ### El code pipeline usará un CodeBuild
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Build"
      provider        = "CodeBuild"
      version         = "1"
      owner           = "AWS"
      input_artifacts = ["code"]
      configuration = {
        ProjectName = "cicd-apply" ## Le decimos que proyecto usará (Que se creo en 6codebuild)
      }
    }
  }

}































  #    stage {
  #        name = "Source"
  #        action{
  #            name = "Source"
  #            category = "Source"
  #            owner = "AWS"
  #            provider = "CodeStarSourceConnection"
  #            version = "1"
  #            output_artifacts = ["code"]
  #            configuration = {
  #                FullRepositoryId = "culturadevops/"
  #                BranchName   = "master"
  #                ConnectionArn =aws_codestarconnections_connection.example.arn
  #                OutputArtifactFormat = "CODE_ZIP"
  #            }
  #        }
  #    }

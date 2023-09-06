### Se especifica en que almacenamient se alojará terraform y sus config
terraform{
    backend "s3" {
        bucket = "practica-mi-repo-para-terraform" ## Debe existir previamente
        encrypt = true
        ## En especifico debe guardar el 'terraform.tfstate' en 'practica-mi-repo-para-terraform'
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}

## Se especifica la nube 

provider "aws" {
    region = "us-east-1"
}
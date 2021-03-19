# provider.tf
provider "aws" {
  version    = "~> 2.22.0"
  region     = "us-east-1"
  shared_credentials_file = "C:\\Users\\Tushar Dashpute\\.aws\\credentials"
  profile                 = "customprofile"
}

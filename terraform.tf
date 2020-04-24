terraform {
  required_version = "~> 0.12.24"

// //For better team work experience is better to use remote state & locking. for test work this could be ommited
//  backend "s3" {
//    bucket         = "terraform-statefile"
//    key            = "terraform.json"
//    dynamodb_table = "terraform-state-lock"
//    region         = "eu-central-1"
//    //there should be separate account & profile for state storage & lock. if possible. security reasons.
//    profile        = "state"
//  }
}

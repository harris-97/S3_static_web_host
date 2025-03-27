variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"

}


variable "bucket_name" {
  description = "The name of the S3 bucket"
  default = "mybucket-unique-name"
}


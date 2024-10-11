variable "region" {
  description = "The AWS region to deploy the S3 bucket."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "index_document" {
  description = "The name of the index document."
  type        = string
}

variable "error_document" {
  description = "The name of the error document."
  type        = string
}

variable "index_file_path" {
  description = "The local path to the index document."
  type        = string
}

variable "error_file_path" {
  description = "The local path to the error document."
  type        = string
}

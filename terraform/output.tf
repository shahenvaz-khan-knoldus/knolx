# Output the website endpoint from the aws_s3_bucket_website_configuration resource
output "s3_website_url" {
  value = "${aws_s3_bucket_website_configuration.website.website_endpoint}/index.html"
}

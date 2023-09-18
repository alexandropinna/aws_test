# Data resource to fetch information about an existing key pair in AWS
# This is generally used to access EC2 instances.
data "aws_key_pair" "key" {
  # Name of the existing key pair in AWS
  key_name = "arroyo-key-test"
}

output "aws_instance_public_ip"{  // this is by default name of an output block.
  value = aws_instance.nginxserver.public_ip
}

output "instance_url" {
  description = "The url to access the nginx server"
  value = "http://${aws_instance.nginxserver.public_ip}"
}

ec2_config = {
volume_size = 40
volume_type = "gp3"
}

/*  so, just for changing anything going in prod, you just fetch that details and give the next possible value that you wanna give
eg: the above one.
So, this means that now the ec2 config volume size value will be 40 and not 30 as given in terraform.tfvars file.
 */

 /* 'ec2_config={volume_size=40, volume_type="gp3"}' */
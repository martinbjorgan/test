resource "aws_elb" "loadbalancer" {
  name = "${var.modulename}"


  subnets = ["${var.SubnetId}"]
  security_groups = ["${var.SecurityGroupId}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
}

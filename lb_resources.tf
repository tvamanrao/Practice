resource "aws_lb" "nw_lb" {
    name = "vam-app-lb"
    internal = false
    load_balancer_type = "network"
    subnet_mapping {
      subnet_id = aws_subnet.subnets[1].id
    }
    //security_groups = [aws_security_group.sg.id]
    tags = {
      "Name" = "Apache Public LB"
    }
    depends_on = [
      aws_instance.deploy_web_ec2
    ]
}
resource "aws_lb_target_group" "lb_tgt_grp" {
    name = "Instances-Target-Group"
    port = 80
    protocol = "TCP"
  //  target_type = "nlb"
    vpc_id = aws_vpc.my_vpc.id
    health_check {
      enabled = true
      healthy_threshold = 3
      interval = 30
      port = 80
      timeout = 10
      protocol = "HTTP"
    }
    depends_on = [
        aws_lb.nw_lb
    ]
}
resource "aws_lb_target_group_attachment" "lb_inst_attc" {
    count = length(var.ec2_name.name)
    target_group_arn = aws_lb_target_group.lb_tgt_grp.arn
    target_id = aws_instance.deploy_web_ec2[count.index].id
    port = 80
    depends_on = [
      aws_lb_target_group.lb_tgt_grp
    ]
}
resource "aws_lb_listener" "lb_lsnr" {
    load_balancer_arn = aws_lb.nw_lb.arn
    port = 80
    protocol = "TCP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.lb_tgt_grp.arn
    }
    depends_on = [
      aws_lb_target_group_attachment.lb_inst_attc
    ]
}

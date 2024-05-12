Hello, I'm seeking your expertise as a DevOps and Cloud Engineer. I plan to deploy an application on AWS using EC2 instances and require your 
help to develop two specific AWS Terraform modules from scratch—no external pre-built modules allowed.

1. VPC Module: Please create a module for a Virtual Private Cloud (VPC).
2. EC2 Module: This module should include an autoscaling group, an application load balancer, and a security group to efficiently manage a fleet 
of EC2 instances. Configure the EC2 instances to use the AMI ID "ami-0b0ea68c435eb488d" and include a simple userdata script that sets up a 
homepage with the message "Auto Deployment from Cloud-AI".

For each module, ensure the following files are included: main.tf, variables.tf, and outputs.tf.

Additionally, create root files (included: main.tf, variables.tf, and outputs.tf at the project root level) that integrates these two modules to 
set up the infrastructure. This configuration should invoke the VPC and EC2 modules, ensuring that they work together to deploy the application.
Provide default values for all the variables defined in variables.tf.

Ensure the application can be accessed through the ALB DNS, and that visitors to the site will see the message "Auto Deployment from Cloud-AI" 
displayed on the webpage.

Please proceed to deploy my application using these modules and provide the executable Terraform codes along with a clear folder structure 
to organize these modules and deployment scripts.
**Terraform AWS Self-Healing Infrastructure**
This project ensures **high availability** and **resilience** by automatically recovering from failures. In AWS, this can be achieved using EC2 instances with **Auto Scaling Groups (ASG)** and **Load Balancers**.
**Terraform** helps automate the provisioning and management of this infrastructure. 

In this project, we will:
Use **Terraform** to deploy an **EC2 instance** in an **Auto Scaling Group**.
Attach a **Load Balancer** to distribute traffic.
Use **Auto Scaling policies** to replace unhealthy instances automatically.

It automatically provisions:
Custom **VPC**
**Public subnets** across multiple Availability Zones.
**Internet Gateway** and **Route Tables**
**Security Groups**
**EC2 Launch template** with Apache Web Server
**Auto Scaling Group (ASG)** for self-healing
**Application Load balancer (ALB)** for high availability

**Overview**
The goal of this project is to showcase how Terraform can autmate and manage AWS resources in a repetable, version-controlled, and production -read manner.
Whenever an EC2 instance fails, the Auto Scaling Group detects the issue and **launces a new instance automatically**, ensuring continious uptime -  a "self-healing" system.

**Architecture**

                  ┌──────────────────────────────┐
                  │        Internet Users        │
                  └──────────────┬───────────────┘
                                 │
                                 ▼
                  ┌──────────────────────────────┐
                  │  Application Load Balancer   │
                  └──────────────┬───────────────┘
                                 │
               ┌────────────────┴────────────────┐
               ▼                                 ▼
     ┌────────────────────┐             ┌────────────────────┐
     │ EC2 Instance (AZ1) │             │ EC2 Instance (AZ2) │
     │  Apache Web Server │             │  Apache Web Server │
     └──────────┬─────────┘             └──────────┬─────────┘
                │                                  │
                └──────────────┬───────────────────┘
                               ▼
                   ┌──────────────────────┐
                   │  Auto Scaling Group  │
                   └──────────┬───────────┘
                              ▼
                     ┌────────────────┐
                     │     VPC + IGW  │
                     │ (2 Subnets AZs)│
                     └────────────────┘

**Project Structure**
│
├── provider.tf           # AWS provider configuration
├── vpc.tf                # VPC, subnets, IGW, route table setup
├── security.tf           # Security group definitions
├── launch_template.tf    # Launch template with user data script
├── autoscaling.tf        # Auto Scaling Group configuration
├── load_balancer.tf      # ALB, target group, and listener setup
├── outputs.tf            # Outputs (like ALB DNS)
├── variables.tf          # Optional input variables
├── .gitignore            # Ignore Terraform cache and state files
└── README.md             # Documentation (you’re reading this)

**Prerequisites**
Before you egin, ensure you have:
 AWS CLI configured with IAM Credentials.
 Terraform v1.13 installed.
 An AWS IAM user with permissions for EC2, VPC, and Auto Scaling
 A key pair(.pem) for SSH access if needed.

 **Deployment Steps** (Can use Gitbash or Powershell in administrator)
 #Initialize Terraform
 ---> terraform init

 #Validate Configuration
 ---> terraform validate

 #Review & Apply Changes
 ---> terraform plan
 ---> terraform apply -auto-approve

 Terraform will:
 Create new VPC and subnets
 Launch 2 EC2 instances using Auto Scaling Groups.
 Deploy an Application Load balancer.
 Server a web page saying: "Hello from Sumedha's Auto -Healing EC2 Insance!".

**Testing the Setup**
Run --> terraform output ---> in gitbash or check the AWS Console -> EC2 ->Load Balancer.
Copy the Load alancer DNS name (e.g. app-lb-12345678.ap-sout-1.el.amazonaws.com)
Open it in the browser -- you should see:
"Hello from Sumedha's Auto-Healing EC2 Instance".

**Testing Self-Healing Behaviour**
Go to AWS Console --> EC2 -->Auto Scaling Groups.
Select your ASG --> "instance Management" tab.
Manually terminate on eof the EC2 instances.
Wait 1-2 minutes.
**NOTE**: Auo Scaling will automatically launch a new EC2 instance, proving the self-healing functionality.

**Clean up Resource**
To avoid the unwanted AWS Charges:
---> terraform destroy -auto-approve
This will cleanly delete:
ALB
EC2 instance
ASG
VPC and subnets
Security groups

**Technologies Used**

Categories	                                     Tools
Infrastructure as Code	                          Terraform
Cloud Provider	                                  AWS
Compute	                                          EC2, Launch template
Networking	                                      VPC, Subnets, IGW, Route Tables
Load balancing	                                  Application Load Balancer (ALB)
Scaling	                                          Auto Scaling Group (ASG)
Security	                                        Security Groups, IAM
Automation	                                      User Data (Bash Script)
 
 

# aws-terraform-ec2-vpc-project
aws-terraform-ec2-vpc-project

This project demonstrates how to provision AWS infrastructure using **Terraform (Infrastructure as Code)**.

The goal of this project is to create a simple AWS network architecture and launch an EC2 instance with a static public IP using Terraform.

---

# Architecture Diagram

![Architecture Diagram](architecture.png)

---

# Project Architecture

The infrastructure created in this project includes:

• VPC (CIDR: 10.81.0.0/16)
• Public Subnet (CIDR: 10.81.3.0/24)
• Internet Gateway
• Route Table with Internet access
• Security Group for instance access
• Network Interface with private IP
• EC2 Instance
• Elastic IP associated with the network interface

---

# Technologies Used

• AWS Cloud
• Terraform
• Linux
• Git & GitHub

---

# Infrastructure Workflow

Terraform provisions the following resources in order:

1. Create VPC
2. Create Subnet inside the VPC
3. Attach Internet Gateway to VPC
4. Configure Route Table for Internet access
5. Create Security Group
6. Create Network Interface with private IP
7. Launch EC2 Instance and attach the network interface
8. Allocate and associate Elastic IP

---

# Project Files

main.tf
Contains all Terraform resources such as VPC, subnet, EC2, and networking components.

fb1.sh
Shell script used as user data to configure the EC2 instance.

Mini_Project_VPC_Creation.drawio
Architecture diagram created using draw.io.

.gitignore
Ensures Terraform state files and provider binaries are not pushed to GitHub.

---

# How to Run the Project

### Clone the repository

```
git clone https://github.com/KrishnaVamsy99/aws-terraform-ec2-vpc-project.git
cd aws-terraform-ec2-vpc-project
```

### Initialize Terraform

```
terraform init
```

### Review the execution plan

```
terraform plan
```

### Apply the infrastructure

```
terraform apply
```

Type **yes** when prompted.

---

# Verify the Deployment

After successful deployment you can verify:

• EC2 instance running in AWS
• Elastic IP attached
• Internet access through Internet Gateway

---

# Learning Outcome

Through this project I learned:

• How to design AWS network architecture
• How to automate infrastructure using Terraform
• How to attach Elastic IP to a Network Interface
• Infrastructure as Code best practices
• Managing Terraform projects using GitHub

---

# Author

Krishna Vamsy

GitHub Profile:
https://github.com/KrishnaVamsy99

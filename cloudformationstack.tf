provider "aws" {
  region = "us-east-2"
  profile = "CW-DATABUS-DEV"
}
resource "aws_cloudformation_stack" "dev-observation" {
  name = "dev-observations2-cloudformation-stack"

  parameters = {
    VPCCidr = "172.31.0.0/16",
    Subnet1Cidr = "172.31.1.0/24",
    Subnet2Cidr = "172.31.2.0/24",
    Subnet3Cidr = "172.31.3.0/24",
  }
  template_body = <<STACK
{
  "Parameters" : {
    "VPCCidr" : {
      "Type" : "String",
      "Default" : "172.31.0.0/16",
      "Description" : "Cidr block of VPC is 172.31.0.0/16."
    },
    "Subnet1Cidr" : {
      "Type" : "String",
      "Default" : "172.31.1.0/24",
      "Description" : "CIDR block for the subnet 1 is 172.31.1.0/24."
    },
    "Subnet2Cidr" : {
      "Type" : "String",
      "Default" : "172.31.2.0/24",
      "Description" : "CIDR block for the subnet 2 is 172.31.2.0/24."
    },
    "Subnet3Cidr" : {
      "Type" : "String",
      "Default" : "172.31.3.0/24",
      "Description" : "CIDR block for the subnet 3 is 172.31.3.0/24"
    }
  },
  "Resources" : {
    "VPC": {
      "Type" : "AWS::EC2::VPC",
      "Properties" : {
        "CidrBlock" : { "Ref" : "VPCCidr" },
        "Tags" : [
          {"Key": "Name", "Value": "dev-observation-cloudformation-vpc"}
        ]
      }
    },
    "Subnet1": {
      "Type" : "AWS::EC2::Subnet",
      "Properties" : {
        "VpcId" : { "Ref" : "VPC" },
        "CidrBlock" : "172.31.1.0/24",
        "Tags" : [
          {"Key": "Name", "Value": "dev-observation-cloudformation-subnet1"}
        ]
      }
    },
    "Subnet2": {
      "Type" : "AWS::EC2::Subnet",
      "Properties" : {
        "VpcId" : { "Ref" : "VPC" },
        "CidrBlock" : "172.31.2.0/24",
        "Tags" : [
          {"Key": "Name", "Value": "dev-observation-cloudformation-subnet2"}
        ]
      }
    },
    "Subnet3": {
      "Type" : "AWS::EC2::Subnet",
      "Properties" : {
        "VpcId" : { "Ref" : "VPC" },
        "CidrBlock" : "172.31.3.0/24",
        "Tags" : [
          {"Key": "Name", "Value": "dev-observation-cloudformation-subnet3"}
        ]
      }
    }
  }
}
STACK
}

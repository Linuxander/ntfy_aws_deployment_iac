# About
[NTFY](https://ntfy.sh/) is a neat tool that lets you obtain notifications on your laptop or iOS/Android phone when your terminal commands succeed or fail.  You can deploy and configure this as a docker image on your computer or a cloud server.

This repository is to simplify the deployment and configuration of that NTFY server on the AWS platform by Terraform automation.  The Terraform script in this repo deploys AWS VPC setup and an EC2 instance configured as an NTFY server with the additional steps to allow notifications to reach iOS devices.

Once the Terraform automation scripts are complete, you can fetch the EC2 instance public IP address.  Use that public IP address to configure your NTFY phone app to listen to notifications.  When you run commands on your computer terminal and append the code below, you will see them pop up on your phone with your commands complete or fail.

### Command Syntax for Success Notifications

After your command, append the following code to obtain notifications on success:

```
&& curl -d "The complete message you want to see in the notification goes here" http://[EC2 IP goes here]/[topic you subscribed to on your phone]
```

### Command Syntax for Failure Notifications

After your command, append the following code to obtain notifications on failure:

```
|| curl -d "The command failed message goes here" http://[EC2 IP goes here]/[topic you subscribed to on your phone]
```

### Combine them to get notified when something fails or succeeds

To get either a failed or success notification on your phone for one command, you can do something like this:

```
[any command goes here] && curl -d "Command succeeded! :)" http://[EC2 public IP]/[topic] || curl -d "Command failed. :(" http://[EC2 public IP]/[topic]
```

This repository allows you to deploy an NTFY server quickly on the AWS platform whenever you need it and destroy the resources when you no longer use it.  It is handy when you want to avoid babysitting the command terminal during procedures that take a while.

# Prerequisites
You will need to have satisfied the following prerequisites to use this repository:
1. Create an AWS account
1. Go to AWS Key Pair and create a key pair named `aws_key_pair_ec2_ntfy_server`
    1. Download the `.pem` file and then you can later log into the server from your local machine following AWS connect instructions on the EC2 instance
1. Install AWS CLI
1. Configure AWS CLI with your account
1. Install Terraform
1. Install NTFY on your iOS/Android device

Once you have accomplished the above steps, clone this repository and deploy the NTFY server to your AWS account.

# Terraform Instruction

1. Clone this repostory
1. Change your directory inside the repository
1. Run `terraform init`
1. Run `terraform apply`
1. Answer `yes` at the prompt
1. Once complete, follow the next steps

# Verify NTFY server is up by accessing the NTFY dashboard

This is just a verification step; nothing else needs to be configured in this section.

1. Log into the AWS console
1. Go to EC2 instance page
1. Click on the NTFY Server instance to get its details
1. Copy the public IP address
1. Open a browser
1. Go to http://[EC2 public IP]
1. You should now see the NTFY server dashboard

# NTFY Phone App | Subscribe to a topic

1. Open the NTFY phone app
1. Click the + symbol to subscribe to a topic
1. Type in the topic name you want the phone to listen to
1. Enable the Use another server
1. Enter http://[EC2 public IP]

# Command Line | Broadcast a message to Topic

Here's the fun part. After you follow these steps, you should see the notification on your phone.

1. Open a terminal window
1. Enter the command `curl -d "Hello world!" http://[EC2 public IP]/[topic you subscribed to on your phone goes here]`
1. Hit `Enter`
1. You should now have received a notification on your phone

# Security

This terraform script by default allows all http/https, and ssh connections from anywhere (`0.0.0.0/0`).  

There are two files where you can list the allowed IP's you want to grant access to.

## Obtaining your public IP address

In a terminal, you can obtain your public IP with the following command:

```
curl ipinfo.io/ip
```

You can also obtain it from a website called `www.ipchicken.com`

## allowed_ips_for_http.txt

The /networking/data/allowed_ips_for_http.txt file is where you can list the public IP addresses you want to allow http/https access from.  

The syntax for multiple IP's should look like this:

```
1.2.3.4/32
5.6.7.8/32
```

Change only the IP address in front of the `/32` characters.

## allowed_ips_for_ssh.txt

The /networking/data/allowed_ips_for_ssh.txt file is where you can list the public IP addresses you want to allow ssh access from.  

The syntax for multiple IP's should look like this:

```
1.2.3.4/32
5.6.7.8/32
```

Change only the IP address in front of the `/32` characters.

## Rerun terraform apply

Apply these changes by running the following command:

```
terraform apply
```

You should now only be able to access the ntfy server dashboard form the IPs listed in the `allowed_ips_for_http.txt` file.

You should now only be able to ssh into the EC2 server following the NTFY instances' connect isntruction from the IPs listed in the `allowed_ips_for_ssh.txt` file.
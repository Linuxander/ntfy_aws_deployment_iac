# About
[NTFY](https://ntfy.sh/) is a tool that lets you obtain notifications on your laptop or iOS/Android phone when your terminal commands succeed or fail.  This is extremely useful when you have command procedures that take several minutes to complete. Leveraging their notification software allows you to progress on other tasks or even walk away from the computer, knowing you will be notified of the results.

Although the NTFY website explains how to install and configure it on your laptop or in a cloud platform, it involves several manual steps.  This may be fine for some people, but it may become a tedious task for us.

This repository simplifies that process for cloud engineers who already have an AWS development environment available. It uses Terraform automation to set up the NTFY server in their AWS account.  This allows you to deploy it when needed and destroy it when you don't with minimal effort.

After running this terraform project, you will have a dedicated NTFY setup with a configured VPC and EC2 instance as your NTFY server. The terraform output provides the server's public IP address. Use that IP to complete the NTFY notification app configuration on your phone. Then, run your everyday commands with additional NTFY commands appended to it.  When your long-running commands are complete, you will receive notifications on your phone.

# Process Overview

To get this up and running, you will need to follow the directions below, which consists of:

1. Complete the prerequisites
1. Clone this repo and `cd` into it
1. Deploy by running `terraform init` and then `terraform apply` commands
1. Configure the NTFY app on your phone using the IP info provided in step 3’s output
1. Run any command in your terminal with NTFY commands to get success and failure notifications on your phone

# Steps

### Step 1 | Prerequisites
You will need to have satisfied the following prerequisites to use this repository:
1. Create an AWS account
1. Go to AWS Key Pair and create a key pair named `aws_key_pair_ec2_ntfy_server`
    1. Download the `.pem` file and then you can later log into the server from your local machine following AWS connect instructions on the EC2 instance
1. Install AWS CLI
1. Configure AWS CLI with your account
1. Install Terraform
1. Install [NTFY for iOS](https://apps.apple.com/us/app/ntfy/id1625396347) or [NTFY for Android](https://play.google.com/store/apps/details?id=io.heckel.ntfy) on your phone

Once you have accomplished the above steps, clone this repository and deploy the NTFY server to your AWS account.

### Step 2 | Terraform Instruction

1. Clone this repository
1. Change your directory inside the repository
1. Run `terraform init`
1. Run `terraform apply`
1. Answer `yes` at the prompt
1. Once complete, copy the public IP address of the NTFY EC2 instance from the `ntfs_server_instance_public_ip` output

The output looks like this:
```
Outputs:

ntfs_server_instance_public_ip = "[COPY IP VALUE FROM HERE]"
```

### Step 3 | Verify NTFY server is up by accessing the NTFY dashboard

This is just a verification step; nothing else needs to be configured in this section.

1. Let the EC2 instance finish installing and configuring the NTFY server by waiting ~20 seconds
1. Open a browser
1. Go to `http://[ENTER ntfs_server_instance_public_ip VALUE HERE]`
1. The NTFY server dashboard should now appear
    1. If it doesn't, give it a few more seconds then refresh the page

### Step 4 | NTFY Phone App | Subscribe to a topic

1. Open the NTFY phone app
1. Click the `+` symbol to subscribe to a topic
1. In the `Topic name` text field, makeup a topic name
    1. The topic name you create will receive messages from the commands in a terminal that uses the same topic name
1. Enable the switch for `Use another server` feature
1. Enter `http://[ENTER ntfs_server_instance_public_ip VALUE HERE]`

### Step 5 | Command Line | Broadcast a message to Topic

Here's the fun part. After you follow these steps, you should see the notification on your phone.

1. Open a terminal window
1. Enter the command `curl -d "Hello world!" http://[ENTER ntfs_server_instance_public_ip VALUE HERE]/[ENTER TOPIC SUBSCRIBED ON PHONE HERE goes here]`
1. Hit `Enter`
1. You should now have received a notification on your phone

# Syntax Overview

### Command Syntax for Success Notifications

After your command, append the following code to obtain notifications on success:

```
&& curl -d "[ENTER SUCCESS MESSAGE HERE]" http://[ENTER ntfs_server_instance_public_ip VALUE HERE]/[ENTER TOPIC SUBSCRIBED ON PHONE HERE]
```

### Command Syntax for Failure Notifications

After your command, append the following code to obtain notifications on failure:

```
|| curl -d "[ENTER FAIL MESSAGE HERE]" http://[ENTER ntfs_server_instance_public_ip VALUE HERE]/[ENTER TOPIC SUBSCRIBED ON PHONE HERE]
```

### Combine them to get notified when something fails or succeeds

To get either a failed or success notification on your phone for one command, you can do something like this:

```
[any command goes here] && curl -d "Command succeeded! :)" http://[ENTER ntfs_server_instance_public_ip VALUE HERE]/[topic] || curl -d "Command failed. :(" http://[ENTER ntfs_server_instance_public_ip VALUE HERE]/[topic]
```

This repository allows you to deploy an NTFY server quickly on the AWS platform whenever needed and destroy the resources when you no longer use it.  It is handy when you want to avoid babysitting the command terminal during procedures that take a while.

# Security Instructions

This terraform script by default allows all http/https, and ssh connections from anywhere (`0.0.0.0/0`).  

There are two files where you can list the allowed IPs you want to grant access to, and they will be applied to the appropriate security group rules.

### Obtaining your public IP address

In a terminal, you can obtain your public IP with the following command:

```
curl ipinfo.io/ip
```

You can also obtain it from a website called `www.ipchicken.com`

### Update allowed_ips_for_http.txt for restricted http/https access

The `/networking/data/allowed_ips_for_http.txt` file is where you can add the list of IPs you want to allow http/https access.  

The syntax for multiple IPs should look like this:

```
1.2.3.4/32
5.6.7.8/32
```

Change only the IP address in front of the `/32` characters.

### Update allowed_ips_for_ssh.txt for restricted ssh access

The `/networking/data/allowed_ips_for_ssh.txt` file is where you can add the list of IPs you want to allow ssh access.

The syntax for multiple IPs should look like this:

```
1.2.3.4/32
5.6.7.8/32
```

Change only the IP address before the `/32` characters.

### Apply security changes using `terraform apply`

Apply these changes by running the following command:

```
terraform apply
```

You should now only be able to access the ntfy server dashboard from the IPs listed in the `allowed_ips_for_http.txt` file.

You should now only be able to ssh into the EC2 server following the NTFY instances' AWS Connect instructions from the IPs listed in the `allowed_ips_for_ssh.txt` file.

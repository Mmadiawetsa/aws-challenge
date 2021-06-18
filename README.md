## The AWS Developer Challenge for Data Engineers
### Instructions

In general feel free to expand/change the challenge in any way you like, just explain your solution and decision making, any concerns around it or limitations etc.

Some information/content is left out intentionally to validate your working experience, please fill in the missing parts.

> Fork this repo with your solution. Ideally, we'd like to see your progression through commits, and don't forget to update the README.md to explain your thought process.

**Please do not reference any websites or published articles. We are looking for original content!**

Please let us know how long the challenge took you. We're not looking for how fast or detailed you are. It's just to give us a clearer idea of what you've produced in the time you decided to take. Feel free to go as big or as small as you want.

### AWS Data Engineer | Challenge Information

This company is ingesting data into a 'data lake' running AWS. Below find a picture of the AWS components used for this company's architecture. 

![AWS-COMPONENTS](/media/awscp.png)

## Section A
### Design an Architecture Diagram - We want to see a picture.
Use the components shown above and create an architecture with your tool of choice (powerpoint / draw.io / etc) showing how to ingest data from an on-premise site into AWS. 

Upload the diagram/picture into the Git repository and indicate where it's saved. Use the given components as far as possible to illustrate your solution.

##### Hints
* Focus on *low cost & high* performance.
* All the data are stored in S3 buckets.
* Athena is used to query the data.
* Show how you will use Step Functions to orchestrate the *ingest* process.
* AWS DynamoDB / CloudWatch must be used.
* Glue Jobs should be used to do the ingest.
* CloudFormation output is a CodeBuild Project
* Git is used to save the terraforms and python / pyspark code.
* You do not have to design/depict the CI/CD, assume that it's already in place.
* Look at the available .tf files to get an understanding of the architecture.
___

## Section B
### Describe the Section A - Architecture Diagram 

Within this Readme.md describe the architecture above, giving detail when and how you would use the selected components.

**Please do not reference any websites or published articles.** 
**We are looking for original content!** 
**We do not want to see definitions of the AWS components.**


##### Hints
* Consider aspects like security (iam / firewalls / vpc / security groups / roles)
* To each component used, give a detailed description on how it fits into the solution, please do not reference existing AWS documentation, use your own words! Feel free to document your thought process. We are interested to find out how you think.
___

## Section C
**Try your best do not keep the section open, we want to see how you apply yourself**

Within the Git Repository Structure:
* Modify the CloudFormation Template [CFN/seed.yaml] in order to create a CodeBuild Project.
* Update the _glue_jobs.tf_, _main.tf_ and _output.tf_ terraform files. 
* Provide the python script that will be used within the glue job, using either python shell or spark, think here about using DynamoDB to keep certain job settings and table structures for S3.
___

## Submit it

Please use a private repo just email us when you are done. 

## Your Solution Starts HERE!!!
Use this area to describe your solution as requested in *_Section B_*. 

1. During Data Migration, Data will be moved from our local data store to Amazon Simple Storage Service. This data will be migrated using the company's VPN which will be connected to the Amazon VPN Gateway to ensure that our data is safe and secure during the transportation process.
2. Amazon Kinesis stream will be used to stream our data from the local data store into Amazon S3:raw. 
3. Lambda functions are used to differentiate our data and in which bucket the data must be stored. 
4. Amazon CloudFormation is used to set up the AWS infrastructure, along with CodeBuild.
5. CodeBuild has an IAM role with administrator access. This role will be used to access the above AWS services on behalf of the user.
6. AWS Step Functions will automate our process. it will make use of lambda functions to keep track of all jobs in progress, all jobs executed, and all job status. 
7. When data first comes into AWS, a lambda function is triggered and this lambda will inform the step function of this new data. The step function will then inform AWS Glue of this new data.
8. AWS glue will categorize, clean, validate, enrich, and transforms this data inside S3 bucket:raw into usable and reliable data structures that can be stored in S3 Bucket:transformed.
9. AWS Glue crawler uses AWS Lambda:crawler to continuously look for new data in S3 Bucket:transformed. 
10. AWS Glue Crawler will create table definitions in the AWS data catalog from the new data. The Data Catalog contains metadata that are used to define ETL jobs and other metadata will be used to transform the data. The data will be transformed from the glue_job.py script.
11. Amazon DynamoDB will store the schema data from the data catalog.
12. S3 Bucket:production will store or final data after all transformation steps are complete.
13. Amazon Athena will query all the data inside S3 Bucket:production
14. The data is now also available for our APIs
15. When a CI build is complete, Cloudwatch event triggers AWS Lambda to copy logs inside the S3 bucket:logs 
16. logs can be viewed using Amazon Api-Gateway
17. Amazon SNS will be used to send CodeBuild status to Data Engineers via email. 
18. AWS Systems manager will store Github SSH Privatekey, github repo url and the branch name. CI/CD pipelines from Github will be validated using these keys stored in AWS SSM 
Once the SSH private key, git branch, and git repo are confirmed using the AWS secret manager. 


## Additional Comments / Information / Concerns
Add info here.


    The diagram is inside the MEDIA folder.

    Filename: githubchallenge.jpg




aws configure # Configure AWS CLI


AWS_ACCESS_KEY_ID # Access Key
AWS_SECRET_ACCESS_KEY # Secret Access Key
AWS_DEFAULT_REGION # Region
AWS_SESSION_TOKEN # Session Token If you are using temporary credentials (such as those obtained by assuming an IAM role), you'll also need to set the session token

###Unix-like system###

export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE 
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-west-2

####on Windows (using Command Prompt)####

set AWS_ACCESS_KEY_ID=AKIASDAVJ7HU3AUS2P5F
set AWS_SECRET_ACCESS_KEY=6JZPMtPoIfVbo/56snQqp/Q2FBTRc7OiN3SK0MAx
set AWS_DEFAULT_REGION=us-east-1




aws configure --profile your-profile-name # Configure AWS CLI with a profile
aws s3 ls --profile your-profile-name # List S3 buckets with a profile
aws s3 ls # List S3 buckets with default profile


aws s3api put-bucket-versioning --bucket <your-bucket-name> --versioning-configuration Status=Enabled # Enable versioning for an S3 bucket

aws s3api put-bucket-versioning --bucket webstaticstatefile --versioning-configuration Status=Enabled




Create a DynamoDB Table (Optional):

###If you want to prevent state corruption when multiple users are applying changes at the same time, you can use a DynamoDB table for state locking

aws dynamodb create-table \
  --table-name <your-lock-table> \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
  --region <your-region>


Example: aws dynamodb create-table --table-name statefile-lock-table --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 --region us-east-1 

output: {
    "TableDescription": {
        "AttributeDefinitions": [
            {
                "AttributeName": "LockID",
                "AttributeType": "S"
            }
        ],
        "TableName": "statefile-lock-table",
        "KeySchema": [
            {
                "AttributeName": "LockID",
                "KeyType": "HASH"
            }
        ],
        "TableStatus": "CREATING",
        "CreationDateTime": "2024-03-28T00:20:43.762000-04:00",
        "ProvisionedThroughput": {
            "NumberOfDecreasesToday": 0,
            "ReadCapacityUnits": 1,
            "WriteCapacityUnits": 1
        },
        








aws s3 ls # List S3 buckets
aws s3 cp file.txt s3://bucket/ # Copy file to S3 bucket

aws ec2 describe-instances # List EC2 instances
aws ec2 start-instances --instance-ids i-1234567890abcdef0 # Start EC2 instance
aws ec2 stop-instances --instance-ids i-1234567890abcdef0 # Stop EC2 instance
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0 # Terminate EC2 instance



# ##################
# LAMBDA ROLE
# ##################

resource "aws_iam_role" "lambda_role" {
    
    name = "DesafioExecutaEMR"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": "AssumeRole"
        }
    ]
}
EOF

    tags = {
        CURSO     = "EDC"
        MODULO    = "1"
        USE_CASE  = "DESAFIO"
    }
}

resource "aws_iam_policy" "lambda_policy" {

    name        = "DesMod1AWSLambdaBasicExecutionRolePolicy"
    path        = "/"
    description = "Provide write permission to CloudWatch logs, S3 buckets and EMR steps"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticmapreduce:*"
            ],
            "Resource": "*"
        },
        {
          "Action": "iam:PassRole",
          "Resource": ["arn:aws:iam::776401046809:role/EMR_DefaultRole",
                       "arn:aws:iam::776401046809:role/EMR_EC2_DefaultRole"],
          "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
    role        = aws_iam_role.lambda_role.name
    policy_arn  = aws_iam_policy.lambda_policy.arn
}
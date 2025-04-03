resource "aws_iam_user" "aws_cli_user1" {
  name = "aws_cli_user1"
}

resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
  user       = aws_iam_user.aws_cli_user1.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "aws_cli_user1_key" {
  user = aws_iam_user.aws_cli_user1.name
}

resource "aws_iam_role" "ec2_s3_access1" {
  name = "ec2-s3-access1"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ec2_s3_access1_policy" {
  name   = "ec2-s3-access1-policy"
  role   = aws_iam_role.ec2_s3_access1.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
     ": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

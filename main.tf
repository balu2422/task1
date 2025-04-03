resource "aws_iam_user" "aws_cli_user" {
  name = "aws_cli_user"
}

resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
  user       = aws_iam_user.aws_cli_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "aws_cli_user_key" {
  user = aws_iam_user.aws_cli_user.name
}

resource "aws_iam_role" "ec2_s3_access" {
  name = "ec2-s3-access"

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

resource "aws_iam_role_policy" "ec2_s3_access_policy" {
  name   = "ec2-s3-access-policy"
  role   = aws_iam_role.ec2_s3_access.id

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

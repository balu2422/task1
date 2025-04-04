resource "aws_iam_user" "aws_cli_user134" {
  name = "aws_cli_user134"
}

resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
  user       = aws_iam_user.aws_cli_user134.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "aws_cli_user1_key" {
  user = aws_iam_user.aws_cli_user134.name
}

resource "aws_iam_role" "ec2_s3_access134" {
  name = "ec2-s3-access134"

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

resource "aws_iam_role_policy" "ec2_s3_access134_policy" {
  name   = "ec2-s3-access134-policy"
  role   = aws_iam_role.ec2_s3_access134.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
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

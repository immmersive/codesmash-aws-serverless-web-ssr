resource "aws_iam_policy" "policy" {
    name            = "ssr-policy"
    description     = "ssr-policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": 
    [
        {
            "Action": "*",
            "Effect": "Allow",            
            "Resource": "*"
        }
    ]
}
EOF
}

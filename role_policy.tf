resource "aws_iam_role_policy_attachment" "role_policy" {
    role            = "${aws_iam_role.role.id}"
    policy_arn      = "${aws_iam_policy.policy.id}"
} 

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "lambda:GetLayerVersion",
        Resource = "arn:aws:lambda:us-east-1:753240598075:layer:LambdaAdapterLayerX86:23"
      }
    ]
  })
}
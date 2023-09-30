
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}



resource "aws_iam_role" "role_assume_lambda" {
  name               = "role-assume-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

//politicas de permissoes
data "aws_iam_policy_document" "perm_lambda_s3_cloudwatch" {
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
      "logs:CreateLogStream"
    ]

    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:PutObject"]

    resources = ["*"]
  }

}

resource "aws_iam_policy" "policy_lambda_s3_cloudwatch" {
  name        = "policy-lambda-s3-cloudwatch"
  path        = "/"
  policy      = data.aws_iam_policy_document.perm_lambda_s3_cloudwatch.json
}

resource "aws_iam_role_policy_attachment" "lambda_s3_cw" {
  role       = aws_iam_role.role_assume_lambda.name
  policy_arn = aws_iam_policy.policy_lambda_s3_cloudwatch.arn
}

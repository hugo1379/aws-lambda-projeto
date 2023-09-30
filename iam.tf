
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

resource "aws_iam_role" "role_lambda_cw_s3" {
  name               = "role-lambda-cw-s3"
  assume_role_policy = data.aws_iam_policy_document.perm_lambda_s3_cloudwatch.json
}

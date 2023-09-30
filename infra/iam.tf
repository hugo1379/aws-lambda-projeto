
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws"]
    }

    actions = ["sts:AssumeRole"]
  }
}



resource "aws_iam_role" "role_assume_lambda" {
  name               = "role_assume_lambda"
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

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = ["arn:aws:s3:::*/*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:PutObject"]

    resources = ["arn:aws:s3:::*/*"]
  }

}

resource "aws_iam_role" "role_lambda_cw_s3" {
  name               = "role_lambda_cw_s3"
  assume_role_policy = data.aws_iam_policy_document.perm_lambda_s3_cloudwatch.json
}
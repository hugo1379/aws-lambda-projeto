data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "lambda_function" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda-function-name"
  role          = aws_iam_role.role_assume_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256

  runtime = "python3.9"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "permitirQueS3AcioneLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket_input.arn

  depends_on = [aws_s3_bucket.bucket_input]
}

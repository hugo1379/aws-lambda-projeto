resource "aws_s3_bucket" "bucket_input" {
  bucket = "bucket-input"

}

resource "aws_s3_bucket" "bucket_output" {
  bucket = "bucket-output"
}

resource "aws_s3_bucket_notification" "bucket_input_notification" {
  bucket = aws_s3_bucket.bucket_input.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "pessoa/"
    filter_suffix       = ".png"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
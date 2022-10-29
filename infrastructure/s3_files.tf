resource "aws_s3_object" "parquet_creation" {

  bucket = aws_s3_bucket.datalake.id

  # remote location for the file
  key = "emr-code/pyspark/01_parquet_creation.py"
  acl = "private"

  # local location of the file
  source = "../etl/01_parquet_creation.py"
  # only update the file if MD5 check is different
  etag = filemd5("../etl/01_parquet_creation.py")

}
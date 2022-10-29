resource "aws_glue_catalog_database" "crawler_db" {
    name = "edc_mod1_desafio_crawler_db"
}

resource "aws_glue_crawler" "crawler" {
    database_name = aws_glue_catalog_database.crawler_db.name
    name = "edc_mod1_desafio_crawler"
    role = ""

    s3_target {
      path = "s3://datalake-edc-modulo1-desafio/staging-zone/radis/"
    }

    configuration = <<EOF
    {
        "Version": 1.0,
        "Grouping": {
            "TableGroupingPolicy": "CombineCompatibleSchemas"
        }
    }
    EOF

    tags = {
        CURSO     = "EDC"
        MODULO    = "1"
        USE_CASE  = "DESAFIO"
    }

}
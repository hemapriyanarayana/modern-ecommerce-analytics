resource "snowflake_schema" "raw" {
  database = snowflake_database.ecommerce.name
  name     = "RAW"
  comment  = "Raw source data ingested from external systems"
}

resource "snowflake_schema" "staging" {
  database = snowflake_database.ecommerce.name
  name     = "STAGING"
  comment  = "Cleaned and standardized data prepared for analytics"
}

resource "snowflake_schema" "marts" {
  database = snowflake_database.ecommerce.name
  name     = "MARTS"
  comment  = "Business-ready dimensional models and analytics tables"
}

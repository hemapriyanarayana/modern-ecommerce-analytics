resource "snowflake_account_role" "analytics" {
  name    = "ECOMMERCE_ANALYST"
  comment = "Role for analytics workloads in the e-commerce platform"
}

resource "snowflake_grant_privileges_to_account_role" "analytics_warehouse_usage" {
  privileges = ["USAGE"]

  account_role_name = snowflake_account_role.analytics.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.ecommerce.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analytics_database_usage" {
  privileges = ["USAGE"]

  account_role_name = snowflake_account_role.analytics.name

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ecommerce.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analytics_schema_usage" {
  for_each = {
    raw     = snowflake_schema.raw.name
    staging = snowflake_schema.staging.name
    marts   = snowflake_schema.marts.name
  }

  privileges = ["USAGE"]

  account_role_name = snowflake_account_role.analytics.name

  on_schema {
    schema_name = "${snowflake_database.ecommerce.name}.${each.value}"
  }
}

resource "snowflake_account_role" "ingest" {
  name    = "ECOMMERCE_INGEST"
  comment = "Role for ingesting source data into the RAW layer"
}

resource "snowflake_grant_privileges_to_account_role" "ingest_warehouse_usage" {
  privileges = ["USAGE"]

  account_role_name = snowflake_account_role.ingest.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.ecommerce.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "ingest_database_usage" {
  privileges = ["USAGE"]

  account_role_name = snowflake_account_role.ingest.name

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ecommerce.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "ingest_raw_usage" {
  privileges = ["USAGE"]

  account_role_name = snowflake_account_role.ingest.name

  on_schema {
    schema_name = "${snowflake_database.ecommerce.name}.${snowflake_schema.raw.name}"
  }
}

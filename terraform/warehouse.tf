resource "snowflake_warehouse" "ecommerce" {
  name                = "ECOMMERCE_WH"
  warehouse_size      = "XSMALL"
  warehouse_type      = "STANDARD"
  auto_suspend        = 60
  auto_resume         = true
  initially_suspended = true

  comment = "Compute warehouse for the Modern E-Commerce Analytics Platform"
}

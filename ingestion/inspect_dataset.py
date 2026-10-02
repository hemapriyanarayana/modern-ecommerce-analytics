from pathlib import Path
import pandas as pd

DATA_DIR = Path("data/raw")


def load_csv(filename):
    return pd.read_csv(DATA_DIR / filename)


# Load source tables
customers = load_csv("olist_customers_dataset.csv")
orders = load_csv("olist_orders_dataset.csv")
order_items = load_csv("olist_order_items_dataset.csv")
payments = load_csv("olist_order_payments_dataset.csv")
products = load_csv("olist_products_dataset.csv")
sellers = load_csv("olist_sellers_dataset.csv")


print("=" * 80)
print("PRIMARY KEY / COMPOSITE KEY CHECKS")
print("=" * 80)

# Check order_items composite key
order_item_duplicates = order_items.duplicated(
    subset=["order_id", "order_item_id"]
).sum()

print(f"\nDuplicate (order_id, order_item_id): {order_item_duplicates:,}")


print("\n" + "=" * 80)
print("REFERENTIAL INTEGRITY CHECKS")
print("=" * 80)

# orders -> customers
missing_customers = (
    ~orders["customer_id"].isin(customers["customer_id"])
).sum()

print(f"\nOrders with missing customer_id: {missing_customers:,}")


# order_items -> orders
missing_orders = (
    ~order_items["order_id"].isin(orders["order_id"])
).sum()

print(f"Order items with missing order_id: {missing_orders:,}")


# order_items -> products
missing_products = (
    ~order_items["product_id"].isin(products["product_id"])
).sum()

print(f"Order items with missing product_id: {missing_products:,}")


# order_items -> sellers
missing_sellers = (
    ~order_items["seller_id"].isin(sellers["seller_id"])
).sum()

print(f"Order items with missing seller_id: {missing_sellers:,}")


print("\n" + "=" * 80)
print("CUSTOMER ID ANALYSIS")
print("=" * 80)

customer_id_per_unique_customer = (
    customers.groupby("customer_unique_id")["customer_id"]
    .nunique()
)

multiple_customer_ids = (
    customer_id_per_unique_customer > 1
).sum()

print(
    f"\nUnique customers with multiple customer_id values: "
    f"{multiple_customer_ids:,}"
)


print("\n" + "=" * 80)
print("PAYMENT ANALYSIS")
print("=" * 80)

payments_per_order = (
    payments.groupby("order_id")
    .size()
)

orders_with_multiple_payments = (
    payments_per_order > 1
).sum()

print(
    f"\nOrders with multiple payment records: "
    f"{orders_with_multiple_payments:,}"
)

print(
    f"Maximum payment records for one order: "
    f"{payments_per_order.max()}"
)

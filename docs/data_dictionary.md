# Data Dictionary — 38 Columns

| Column                   | Type    | Description                                                                 |
| ------------------------ | ------- | --------------------------------------------------------------------------- |
| customer_id              | STRING  | Unique customer ID                                                          |
| first_name               | STRING  | First name                                                                  |
| last_name                | STRING  | Last name                                                                   |
| full_name                | STRING  | Concatenated full name                                                      |
| email                    | STRING  | Email address                                                               |
| phone                    | STRING  | 10-digit mobile number                                                      |
| gender                   | STRING  | Male/Female/Other/Unknown                                                   |
| age                      | INT64   | Age in years (18-90)                                                        |
| age_group                | STRING  | 18-25, 26-35, 36-45, 46-55, 56+                                             |
| city                     | STRING  | Customer city                                                               |
| state                    | STRING  | Customer state                                                              |
| pincode                  | STRING  | 6-digit postal code                                                         |
| signup_date              | DATE    | Registration date                                                           |
| membership_tier          | STRING  | Silver/Gold/Platinum/None                                                   |
| acquisition_channel      | STRING  | How customer was acquired                                                   |
| preferred_device         | STRING  | Mobile/Desktop/Tablet/App                                                   |
| preferred_os             | STRING  | Android/iOS/Windows/MacOS                                                   |
| preferred_payment        | STRING  | UPI/Card/COD/EMI/Wallet                                                     |
| total_orders             | INT64   | Total orders placed                                                         |
| total_spent_inr          | FLOAT64 | Total spend in INR                                                          |
| avg_order_value_inr      | FLOAT64 | Average order value                                                         |
| favorite_category        | STRING  | Most shopped category                                                       |
| favorite_subcategory     | STRING  | Most shopped subcategory                                                    |
| last_purchase_date       | DATE    | Most recent order date                                                      |
| days_since_last_purchase | INT64   | Days since last order                                                       |
| recency_bucket           | STRING  | 0-30/31-90/91-180/181-365/365+ days                                         |
| total_returns            | INT64   | Items returned                                                              |
| return_reason            | STRING  | Reason for return                                                           |
| total_complaints         | INT64   | Complaints raised                                                           |
| avg_product_rating       | FLOAT64 | Rating given (1.0-5.0)                                                      |
| sessions_per_month       | INT64   | Monthly platform sessions                                                   |
| discount_usage_pct       | FLOAT64 | Percentage of orders placed using discounts                                 |
| coupons_used             | INT64   | Total coupons applied                                                       |
| churn                    | BOOLEAN | TRUE = churned, FALSE = active                                              |
| is_churned               | INT64   | 1 = churned, 0 = active                                                     |
| churn_date               | DATE    | Date of churn                                                               |
| churn_reason             | STRING  | Reason for customer churn                                                   |
| row_num                  | INT64   | Row number generated using ROW_NUMBER() for duplicate detection and removal |
|                          |         |                                                                             |

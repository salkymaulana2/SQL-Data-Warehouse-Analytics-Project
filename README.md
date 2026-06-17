SQL Data Warehouse Analytics Project

A end-to-end SQL analytics project built on a data warehouse schema, covering exploratory analysis, performance reporting, and customer/product segmentation. The project demonstrates real-world analytical patterns using T-SQL window functions, CTEs, and aggregation techniques.

"This project was completed following a guided tutorial. All queries were written and understood independently"

---

## 🗃️ Database Schema

The project uses a **Gold Layer** schema — clean, analysis-ready tables following a star schema design.

### `gold.dim_customers` — 18,484 records
| Column | Description |
|---|---|
| `customer_key` | Surrogate key |
| `customer_id` | Source system ID |
| `customer_number` | Business identifier |
| `first_name`, `last_name` | Customer name |
| `country` | Country of residence |
| `marital_status` | Marital status |
| `gender` | Gender |
| `birthdate` | Date of birth |
| `create_date` | Account creation date |

### `gold.dim_products` — 295 records
| Column | Description |
|---|---|
| `product_key` | Surrogate key |
| `product_id` | Source system ID |
| `product_number` | Business identifier |
| `product_name` | Product name |
| `category_id`, `category` | Product category |
| `subcategory` | Product subcategory |
| `maintenance` | Maintenance flag |
| `cost` | Product cost |
| `product_line` | Product line |
| `start_date` | Product launch date |

### `gold.fact_sales` — 60,398 records
| Column | Description |
|---|---|
| `order_number` | Order identifier |
| `product_key` | FK to dim_products |
| `customer_key` | FK to dim_customers |
| `order_date` | Date order was placed |
| `shipping_date` | Date order was shipped |
| `due_date` | Due date |
| `sales_amount` | Revenue from the order line |
| `quantity` | Units sold |
| `price` | Unit price |

---

## 📁 Project Structure

```
├── 1-Create_Database.sql           # Database and table setup, bulk data load
├── 2-Change_over_time_Analysis.sql # Monthly sales trend analysis
├── 3-cumulative_analysis.sql       # Running totals and moving averages
├── 4-Performance_analysis.sql      # Year-over-year product performance
├── 5-part_to_whole_Analysis.sql    # Category contribution to total sales
├── 6-data_segmentation_prt1.sql    # Product segmentation by cost range
├── 6-data_segmentation_prt2.sql    # Customer segmentation (VIP/Regular/New)
├── Customers_report.sql            # Full customer KPI report
└── products_report.sql             # Full product KPI report
```

---

## 🔍 Analysis Breakdown

### 1. Change Over Time Analysis
**File:** `2-Change_over_time_Analysis.sql`

Tracks how key sales metrics evolve month by month.

- Monthly total sales revenue
- Distinct customer count per month
- Total quantity sold per month

> Useful for spotting seasonality, growth trends, and anomalies over time.

---

### 2. Cumulative Analysis
**File:** `3-cumulative_analysis.sql`

Uses SQL **window functions** to build progressive metrics.

- Running total sales (cumulative sum by month)
- Moving average of product price over time

> Helps answer: "Are we trending up overall, or just having a good month?"

---

### 3. Performance Analysis (Year-over-Year)
**File:** `4-Performance_analysis.sql`

Compares each product's yearly sales against two benchmarks using window functions (`LAG`, `AVG OVER`).

- **vs. Average:** Is this product above or below its own historical average?
- **vs. Previous Year:** Did sales increase, decrease, or stay the same?

> Surfaces which products are consistently strong and which are declining.

---

### 4. Part-to-Whole Analysis
**File:** `5-part_to_whole_Analysis.sql`

Calculates each product category's share of total revenue.

- Total sales per category
- Percentage contribution to overall sales

> Answers: "Which categories actually drive the business?"

---

### 5. Data Segmentation
**Files:** `6-data_segmentation_prt1.sql`, `6-data_segmentation_prt2.sql`

**Product Segmentation** — Groups products by cost range:
- Below $100 / $100–$500 / $500–$1,000 / Above $1,000

**Customer Segmentation** — Classifies customers by purchase behavior:
| Segment | Criteria |
|---|---|
| **VIP** | 12+ months lifespan AND total spending > $5,000 |
| **Regular** | 12+ months lifespan AND total spending ≤ $5,000 |
| **New** | Lifespan < 12 months |

---

### 6. Customer Report
**File:** `Customers_report.sql`

A comprehensive customer-level report built with CTEs. Covers:

- **Demographics:** Age, age group (Under 20, 20–29, 30–39, 40–49, 50+)
- **Segment:** VIP / Regular / New
- **Engagement metrics:** Total orders, total sales, quantity, products purchased
- **KPIs:**
  - **Recency** — months since last order
  - **Average Order Value (AOV)** — total sales ÷ total orders
  - **Average Monthly Spend** — total sales ÷ lifespan in months

---

### 7. Product Report
**File:** `products_report.sql`

A comprehensive product-level report. Covers:

- **Attributes:** Category, subcategory, cost
- **Segment:** High-Performer (>$50K) / Mid-Range (≥$10K) / Low-Performer
- **Sales metrics:** Total orders, sales, quantity, unique customers
- **KPIs:**
  - **Recency** — months since last sale
  - **Average Selling Price**
  - **Average Order Revenue (AOR)**
  - **Average Monthly Revenue**

---

## 🛠️ Tech Stack

- **Database:** Microsoft SQL Server
- **Language:** T-SQL
- **Concepts used:** CTEs, Window Functions (`LAG`, `SUM OVER`, `AVG OVER`), `DATEDIFF`, `DATETRUNC`, `CASE` statements, Star Schema joins

---

## ⚙️ Setup Instructions

1. Open **SQL Server Management Studio (SSMS)**
2. Run `1-Create_Database.sql` to create the database, tables, and load the CSV data
   - Update the file paths in the `BULK INSERT` statements to match your local CSV locations
3. Run the analysis scripts in any order — they are all independent queries

---

## 💡 Key SQL Concepts Demonstrated

- **Star Schema** — Fact and dimension table joins
- **Window Functions** — Running totals, moving averages, year-over-year with `LAG()`
- **CTEs** — Multi-step logic organized into readable layers
- **Conditional Aggregation** — `CASE WHEN` for segmentation and labeling
- **Date Functions** — `DATEDIFF`, `DATETRUNC`, `YEAR()`, `MONTH()`

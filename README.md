# 🏭 Supply Chain Analysis — SQL Project

A structured end-to-end SQL project analyzing a beauty & personal care supply chain dataset. The analysis covers data cleaning, exploratory data analysis (EDA), and advanced SQL techniques across revenue, sales, inventory, shipping, supplier, and manufacturing dimensions.

---

## 📁 Project Structure

```
supply-chain-sql-analysis/
├── supply_chain_data.csv          # Raw dataset (100 records, 24 columns)
├── supply_chain_analysis.sql      # Full SQL query file (4 phases, 25 queries)
├── supply_chain_insights.txt      # Project outline and analysis roadmap
└── README.md                      # Project documentation
```

---

## 📊 Dataset Overview

| Property | Details |
|---|---|
| **Records** | 100 rows |
| **Columns** | 24 features |
| **Domain** | Beauty & Personal Care Supply Chain |
| **Product Categories** | Haircare, Skincare, Cosmetics |
| **Suppliers** | Supplier 1 – 5 |
| **Locations** | Mumbai, Delhi, Bangalore, Chennai, Kolkata |
| **Shipping Carriers** | Carrier A, B, C |
| **Transport Modes** | Road, Air, Rail, Sea |
| **Routes** | Route A, B, C |

### Key Columns

| Column | Description |
|---|---|
| `Product type` | Category of product (haircare / skincare / cosmetics) |
| `SKU` | Unique product identifier |
| `Price` | Selling price (₹) |
| `Revenue generated` | Total revenue per SKU |
| `Number of products sold` | Units sold |
| `Stock levels` | Current inventory count |
| `Defect rates` | Quality defect rate (%) |
| `Shipping costs` | Cost to ship the order |
| `Shipping times` | Delivery time in days |
| `Shipping carriers` | Logistics partner used |
| `Transportation modes` | Mode of transport |
| `Supplier name` | Supplying vendor |
| `Lead time` | Supplier lead time (days) |
| `Manufacturing costs` | Cost to manufacture the product |
| `Production volumes` | Units produced |
| `Inspection results` | Quality check result (Pass / Fail / Pending) |
| `Costs` | General transport/operational cost |

---

## 🔢 Summary Statistics

| Metric | Value |
|---|---|
| Total Revenue | ₹5,77,604.82 |
| Average Price | ₹49.46 |
| Average Shipping Cost | ₹5.55 |
| Average Defect Rate | 2.28% |
| Price Range | ₹1.70 – ₹99.17 |
| Cost Range | ₹103.92 – ₹997.41 |

---

## 🔍 Analysis Phases

### Phase 1 — Data Understanding
- Counted total rows
- Previewed dataset structure
- Explored numeric column ranges (min, max, avg price)

### Phase 2 — Data Cleaning
- Checked for NULL values across key columns (`Product type`, `SKU`, `Revenue generated`)
- Identified duplicate SKUs using `GROUP BY` + `HAVING`
- Verified distinct product types
- Flagged invalid prices (≤ 0) and negative revenue
- Detected defect rate outliers (> 10%)

### Phase 3 — Exploratory Data Analysis (EDA)

#### 📈 Section A — Revenue Analysis
- **Q1** Total revenue across all products
- **Q2** Revenue breakdown by product type
- **Q3** Top 10 highest revenue SKUs
- **Q4** Average revenue per product

#### 🛒 Section B — Sales Analysis
- **Q5** Most sold products by unit volume
- **Q6** Sales comparison across product types
- **Q7** High revenue but low sales products (premium pricing insight)

#### 📦 Section C — Inventory Analysis
- **Q8** Low stock products (reorder risk)
- **Q9** Overstocked products (holding cost risk)
- **Q10** Inventory risk matrix — high stock vs. low sales

#### 🚚 Section D — Shipping Analysis
- **Q11** Average shipping cost across all orders
- **Q12** Shipping cost comparison by carrier
- **Q13** Average shipping time by transport mode
- **Q14** Most cost-efficient transport mode

#### 🏭 Section E — Supplier Analysis
- **Q15** Revenue contribution by supplier
- **Q16** Average defect rate per supplier
- **Q17** Average lead time per supplier

#### ⚙️ Section F — Manufacturing Analysis
- **Q18** Manufacturing cost by product type
- **Q19** Top 10 SKUs by production volume
- **Q20** Highest manufacturing cost products

### Phase 4 — Advanced SQL Analysis
- **Q21** Revenue ranking using `RANK()` window function
- **Q22** Supplier ranking using `DENSE_RANK()` window function
- **Q23** Running revenue total using `SUM() OVER(ORDER BY ...)`
- **Q24** Above-average revenue products using a `WITH` CTE
- **Q25** Best-performing product category using a CTE

---

## 🛠️ SQL Concepts Used

| Concept | Used In |
|---|---|
| `GROUP BY` + Aggregates (`SUM`, `AVG`, `COUNT`) | Q2, Q5, Q6, Q12, Q15–Q18 |
| `ORDER BY` + `LIMIT` | Q3, Q5, Q8, Q9, Q19, Q20 |
| `HAVING` | Q2 (duplicate check) |
| `WHERE` with conditions | Data cleaning queries |
| `DISTINCT` | Product type check |
| `RANK()` Window Function | Q21 |
| `DENSE_RANK()` Window Function | Q22 |
| `SUM() OVER()` Running Total | Q23 |
| Common Table Expressions (CTEs) | Q24, Q25 |
| Subqueries | Q24 (inline avg comparison) |

---

## 💡 Key Business Insights

- **Revenue leaders** — Skincare and cosmetics consistently outperform haircare in total revenue.
- **Inventory risk** — Several SKUs show high stock levels but low sales, indicating overstock and potential wastage cost.
- **Supplier quality** — Defect rates and lead times vary significantly across suppliers, offering a clear case for supplier renegotiation.
- **Shipping efficiency** — Road and Rail transport show lower average costs vs. Air, while shipping time differences guide mode selection decisions.
- **Premium products** — Some SKUs generate high revenue despite low unit sales, pointing to a premium pricing segment worth protecting.

---

## ⚙️ How to Run

1. Import `supply_chain_data.csv` into your MySQL database:
   ```sql
   CREATE DATABASE supply_chain;
   USE supply_chain;
   -- Then import the CSV via MySQL Workbench or LOAD DATA INFILE
   ```

2. Run the queries in `supply_chain_analysis.sql` sequentially, phase by phase.

3. Each query is independently executable — you can jump to any section directly.

---

## 🧰 Tools & Technologies

- **Database** — MySQL
- **IDE** — MySQL Workbench
- **Language** — SQL (DDL + DML + Window Functions + CTEs)
- **Data** — CSV (imported manually)

---

## 👤 Author

> Project by **[B.Sai Sagar]**

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

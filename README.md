# Customer Funnel and Growth Analysis for an E-Commerce Platform

## 📌 Project Overview

A self-guided Product Analytics project analyzing user behavior across an e-commerce customer journey using **MySQL** and the **AARRR framework**.

The analysis focuses on understanding the customer funnel, identifying conversion bottlenecks, evaluating product and brand performance, segmenting customers by purchase behavior, and identifying opportunities to improve retention and revenue.

---

## 🎯 Business Objective

The objective of this project was to answer four key questions:

1. Where are users dropping off in the customer funnel?
2. Which products, brands and price segments perform best?
3. Which customer segments contribute the most revenue?
4. What product and business actions could improve conversion, retention and revenue?

---

## 🧩 Analytical Framework — AARRR

The project was structured around the **AARRR (Pirate Metrics) framework**:

| Stage | Analysis |
|---|---|
| **Acquisition** | User base and product interaction |
| **Activation** | View → Cart conversion |
| **Retention** | D1 and D7 retention |
| **Revenue** | Purchases, AOV, product, price and customer revenue |
| **Referral** | Not analyzed due to lack of referral data |

---

## 📊 Dataset

The dataset is an **event-level e-commerce dataset**, where each row represents a user interaction.

### Key fields

- `user_id` — Unique customer identifier
- `event_time` — Timestamp of user activity
- `event_type` — View, Cart, Purchase, etc.
- `product_id` — Product identifier
- `brand` — Product brand
- `price` — Product price

### Dataset scale

- **391K+ unique users**
- **1M+ e-commerce events**
- **241K+ purchases**
- **~1.206M total revenue**

---

## 🔍 Analysis Performed

### 1. Customer Funnel Analysis

Analyzed the complete customer journey:

**View → Cart → Purchase**

Key metrics:

- View → Cart conversion: **23.54%**
- Cart → Purchase conversion: **28.86%**
- View → Purchase conversion: **6.79%**
- Cart abandonment: **71.14%**

---

### 2. Brand Performance Analysis

Analyzed brands based on:

- Views
- Purchases
- Conversion rate
- Revenue contribution

Identified high-converting brands with relatively lower visibility, highlighting potential opportunities for targeted product exposure.

---

### 3. Price Segment Analysis

Products were grouped into five price ranges:

- Under 5
- 5–20
- 20–50
- 50–100
- 100+

Conversion showed a strong decline with increasing price:

| Price Range | Conversion |
|---|---:|
| Under 5 | **17.71%** |
| 5–20 | **8.36%** |
| 20–50 | **2.95%** |
| 50–100 | **1.72%** |
| 100+ | **1.01%** |

---

### 4. Product Performance Analysis

Analyzed product-level:

- Views
- Cart interactions
- Purchases
- Conversion
- Revenue

This helped identify high-performing products, conversion bottlenecks and products with strong conversion but relatively lower visibility.

---

### 5. Customer Segmentation

Customers were segmented according to purchase frequency:

- **One-time:** 1 purchase
- **Repeat:** 2–3 purchases
- **Loyal:** 4–7 purchases
- **Highly Engaged:** 8+ purchases

Key finding:

> **Highly Engaged customers represented 27.47% of customers but contributed 53.9% of revenue.**

---

### 6. Retention Analysis

Analyzed early-stage customer retention using D1 and D7 retention.

- **D1 Retention: 7.64%**
- **D7 Retention: 2.86%**

The decline indicates significant drop-off in user engagement over the first week.

---

## 💡 Key Business Insights

### 1. High Cart Abandonment

**71.14% of cart users did not complete a purchase**, making checkout optimization a major opportunity.

### 2. Strong Price Sensitivity

Conversion declined from **17.71% for sub-5 products to 1.01% for 100+ products**, suggesting significant price sensitivity within the observed customer base.

### 3. High-Value Customers Drive Disproportionate Revenue

**27.47% of Highly Engaged customers generated 53.9% of revenue**, highlighting the importance of retaining high-frequency customers.

### 4. High-Converting Products Can Be Underexposed

Certain brands/products demonstrated strong conversion despite relatively lower traffic, indicating potential opportunities to improve product discovery and visibility.

### 5. Early Retention Drops Significantly

D1 retention of **7.64%** declined to **2.86% by D7**, indicating an opportunity to strengthen early user engagement and reactivation.

---

## 🚀 Business Recommendations

### 1. Optimize Checkout

Investigate the cart-to-purchase journey and address potential friction around:

- Checkout complexity
- Payment failures
- Shipping costs
- Unexpected charges
- Purchase hesitation

### 2. Prioritize High-Value Customers

Develop targeted retention initiatives for highly engaged customers through:

- Personalized recommendations
- Loyalty programs
- Exclusive offers
- Cross-selling

### 3. Optimize Product & Pricing Strategy

Balance conversion and revenue rather than optimizing solely for conversion.

Use lower-priced products as potential entry points while leveraging bundles and cross-selling to increase customer value.

### 4. Improve Visibility of High-Converting Products

Test increased exposure through:

- Product recommendations
- Search placement
- Homepage visibility
- Targeted promotions

### 5. Strengthen Early Retention

Use personalized recommendations, re-engagement campaigns and relevant product alerts to encourage users to return.

---

## 🛠️ Tools & SQL Concepts

**Tool:** MySQL

### SQL techniques used

- Aggregations
- `GROUP BY`
- `CASE WHEN`
- `COUNT(DISTINCT)`
- Conditional aggregation
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- Date functions
- `DATE_ADD()`
- `DATEDIFF()`

---

## 📁 Repository Structure

```text
customer-funnel-growth-ecommerce/
│
├── README.md
│
└── sql/
    ├── 01_data_exploration.sql
    ├── 02_funnel_analysis.sql
    ├── 03_brand_analysis.sql
    ├── 04_customer_segmentation.sql
    ├── 05_product_analysis.sql
    ├── 06_revenue_analysis.sql
    └── 07_retention_analysis.sql

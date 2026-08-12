-- ============================================================
-- CUSTOMER FUNNEL AND GROWTH ANALYSIS
-- 01 - DATA EXPLORATION
-- ============================================================

-- 1. Total number of events
SELECT COUNT(*) AS total_events
FROM ecommerce_events;


-- 2. Total unique users
SELECT COUNT(DISTINCT user_id) AS total_unique_users
FROM ecommerce_events;


-- 3. Event type distribution
SELECT
    event_type,
    COUNT(*) AS event_count,
    COUNT(DISTINCT user_id) AS unique_users
FROM ecommerce_events
GROUP BY event_type
ORDER BY event_count DESC;


-- 4. Dataset date range
SELECT
    MIN(event_time) AS first_date,
    MAX(event_time) AS last_date,
    DATEDIFF(MAX(event_time), MIN(event_time)) AS days_of_data
FROM ecommerce_events;


-- 5. Overall purchases and revenue
SELECT
    COUNT(*) AS total_purchases,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(AVG(price), 2) AS average_order_value
FROM ecommerce_events
WHERE event_type = 'purchase';

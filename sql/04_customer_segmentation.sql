-- ============================================================
-- CUSTOMER FUNNEL AND GROWTH ANALYSIS
-- 04 - CUSTOMER SEGMENTATION
-- ============================================================


-- 1. Calculate purchase frequency for each customer

WITH user_purchases AS (
    SELECT
        user_id,
        COUNT(*) AS purchase_count
    FROM ecommerce_events
    WHERE event_type = 'purchase'
    GROUP BY user_id
)

SELECT
    user_id,
    purchase_count,

    CASE
        WHEN purchase_count = 1 THEN 'One-time'
        WHEN purchase_count BETWEEN 2 AND 3 THEN 'Repeat'
        WHEN purchase_count BETWEEN 4 AND 7 THEN 'Loyal'
        WHEN purchase_count >= 8 THEN 'Highly Engaged'
    END AS customer_segment

FROM user_purchases;


-- 2. Customer segment distribution

WITH user_purchases AS (
    SELECT
        user_id,
        COUNT(*) AS purchase_count
    FROM ecommerce_events
    WHERE event_type = 'purchase'
    GROUP BY user_id
),

customer_segments AS (
    SELECT
        user_id,
        CASE
            WHEN purchase_count = 1 THEN 'One-time'
            WHEN purchase_count BETWEEN 2 AND 3 THEN 'Repeat'
            WHEN purchase_count BETWEEN 4 AND 7 THEN 'Loyal'
            WHEN purchase_count >= 8 THEN 'Highly Engaged'
        END AS customer_segment
    FROM user_purchases
)

SELECT
    customer_segment,
    COUNT(*) AS users,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM customer_segments
GROUP BY customer_segment
ORDER BY
    CASE
        WHEN customer_segment = 'One-time' THEN 1
        WHEN customer_segment = 'Repeat' THEN 2
        WHEN customer_segment = 'Loyal' THEN 3
        WHEN customer_segment = 'Highly Engaged' THEN 4
    END;


-- 3. Revenue contribution by customer segment

WITH user_purchases AS (
    SELECT
        user_id,
        COUNT(*) AS purchase_count,
        SUM(price) AS revenue
    FROM ecommerce_events
    WHERE event_type = 'purchase'
    GROUP BY user_id
),

customer_segments AS (
    SELECT
        user_id,
        revenue,
        CASE
            WHEN purchase_count = 1 THEN 'One-time'
            WHEN purchase_count BETWEEN 2 AND 3 THEN 'Repeat'
            WHEN purchase_count BETWEEN 4 AND 7 THEN 'Loyal'
            WHEN purchase_count >= 8 THEN 'Highly Engaged'
        END AS customer_segment
    FROM user_purchases
)

SELECT
    customer_segment,
    COUNT(*) AS users,
    ROUND(SUM(revenue), 2) AS revenue,

    ROUND(
        SUM(revenue) * 100.0 /
        SUM(SUM(revenue)) OVER (),
        2
    ) AS revenue_percentage

FROM customer_segments

GROUP BY customer_segment

ORDER BY revenue DESC;

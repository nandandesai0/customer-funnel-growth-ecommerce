-- ============================================================
-- CUSTOMER FUNNEL AND GROWTH ANALYSIS
-- 06 - REVENUE ANALYSIS
-- ============================================================


-- 1. Overall revenue and purchase metrics

SELECT
    COUNT(*) AS total_purchases,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(AVG(price), 2) AS average_purchase_value
FROM ecommerce_events
WHERE event_type = 'purchase';


-- 2. Revenue contribution by customer segment

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


-- 3. Revenue by price range

SELECT
    CASE
        WHEN price < 5 THEN 'Under 5'
        WHEN price < 20 THEN '5 - 20'
        WHEN price < 50 THEN '20 - 50'
        WHEN price < 100 THEN '50 - 100'
        ELSE '100+'
    END AS price_range,

    COUNT(*) AS purchases,
    ROUND(SUM(price), 2) AS revenue,
    ROUND(AVG(price), 2) AS average_purchase_value

FROM ecommerce_events

WHERE event_type = 'purchase'

GROUP BY price_range

ORDER BY
    CASE
        WHEN price_range = 'Under 5' THEN 1
        WHEN price_range = '5 - 20' THEN 2
        WHEN price_range = '20 - 50' THEN 3
        WHEN price_range = '50 - 100' THEN 4
        WHEN price_range = '100+' THEN 5
    END;

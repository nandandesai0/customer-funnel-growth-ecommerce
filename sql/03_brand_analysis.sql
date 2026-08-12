-- ============================================================
-- CUSTOMER FUNNEL AND GROWTH ANALYSIS
-- 03 - BRAND PERFORMANCE ANALYSIS
-- ============================================================


-- 1. Brand-level purchase and revenue performance

SELECT
    brand,
    COUNT(*) AS purchases,
    ROUND(SUM(price), 2) AS revenue,
    ROUND(AVG(price), 2) AS average_purchase_price
FROM ecommerce_events
WHERE event_type = 'purchase'
GROUP BY brand
ORDER BY revenue DESC;


-- 2. Brand contribution to total revenue

SELECT
    brand,
    ROUND(SUM(price), 2) AS revenue,

    ROUND(
        SUM(price) * 100.0 /
        (SELECT SUM(price)
         FROM ecommerce_events
         WHERE event_type = 'purchase'),
        2
    ) AS revenue_percentage

FROM ecommerce_events
WHERE event_type = 'purchase'

GROUP BY brand

ORDER BY revenue DESC;


-- 3. Top brands by purchase volume

SELECT
    brand,
    COUNT(*) AS purchases,
    ROUND(SUM(price), 2) AS revenue
FROM ecommerce_events
WHERE event_type = 'purchase'
GROUP BY brand
ORDER BY purchases DESC
LIMIT 10;

-- ============================================================
-- CUSTOMER FUNNEL AND GROWTH ANALYSIS
-- 05 - PRODUCT PERFORMANCE ANALYSIS
-- ============================================================


-- 1. Product-level views, purchases and revenue

SELECT
    product_id,

    SUM(event_type = 'view') AS views,

    SUM(event_type = 'purchase') AS purchases,

    ROUND(
        SUM(
            CASE
                WHEN event_type = 'purchase' THEN price
                ELSE 0
            END
        ), 2
    ) AS revenue,

    ROUND(
        SUM(event_type = 'purchase') * 100.0 /
        NULLIF(SUM(event_type = 'view'), 0),
        2
    ) AS conversion_rate

FROM ecommerce_events

GROUP BY product_id

ORDER BY revenue DESC

LIMIT 10;


-- 2. Product performance across the funnel

SELECT
    product_id,

    SUM(event_type = 'view') AS views,
    SUM(event_type = 'cart') AS cart_events,
    SUM(event_type = 'purchase') AS purchases,

    ROUND(
        SUM(event_type = 'cart') * 100.0 /
        NULLIF(SUM(event_type = 'view'), 0),
        2
    ) AS view_to_cart_rate,

    ROUND(
        SUM(event_type = 'purchase') * 100.0 /
        NULLIF(SUM(event_type = 'cart'), 0),
        2
    ) AS cart_to_purchase_rate

FROM ecommerce_events

GROUP BY product_id

ORDER BY purchases DESC

LIMIT 10;


-- 3. Top products by revenue

SELECT
    product_id,

    ROUND(
        SUM(
            CASE
                WHEN event_type = 'purchase' THEN price
                ELSE 0
            END
        ), 2
    ) AS revenue,

    COUNT(
        CASE
            WHEN event_type = 'purchase' THEN 1
        END
    ) AS purchases

FROM ecommerce_events

GROUP BY product_id

ORDER BY revenue DESC

LIMIT 10;

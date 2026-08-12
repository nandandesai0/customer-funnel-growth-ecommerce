-- ============================================================
-- CUSTOMER FUNNEL AND GROWTH ANALYSIS
-- 02 - FUNNEL ANALYSIS
-- ============================================================


-- 1. Overall funnel: viewers, cart users and purchasers

SELECT
    COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS viewers,
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS cart_users,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchasers
FROM ecommerce_events;


-- 2. Funnel conversion rates

SELECT
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END)
        * 100.0 /
        COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END), 2
    ) AS view_to_cart,

    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END)
        * 100.0 /
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END), 2
    ) AS cart_to_purchase,

    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END)
        * 100.0 /
        COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END), 2
    ) AS overall_conversion
FROM ecommerce_events;


-- 3. Cart abandonment rate

SELECT
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END)
        AS cart_users,

    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END)
        AS purchasers,

    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END)
        -
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END)
        AS abandoned_users,

    ROUND(
        (
            COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END)
            -
            COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END)
        ) * 100.0 /
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END),
        2
    ) AS cart_abandonment_rate
FROM ecommerce_events;


-- 4. Conversion by product price range

SELECT
    CASE
        WHEN price < 5 THEN 'Under 5'
        WHEN price < 20 THEN '5 - 20'
        WHEN price < 50 THEN '20 - 50'
        WHEN price < 100 THEN '50 - 100'
        ELSE '100+'
    END AS price_range,

    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END)
        AS cart_users,

    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END)
        AS purchase_users,

    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END)
        * 100.0 /
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END),
        2
    ) AS cart_to_purchase_rate

FROM ecommerce_events

GROUP BY price_range

ORDER BY
    CASE
        WHEN price_range = 'Under 5' THEN 1
        WHEN price_range = '5 - 20' THEN 2
        WHEN price_range = '20 - 50' THEN 3
        WHEN price_range = '50 - 100' THEN 4
        WHEN price_range = '100+' THEN 5
    END;

-- ============================================================
-- CUSTOMER FUNNEL AND GROWTH ANALYSIS
-- 07 - RETENTION ANALYSIS
-- ============================================================


-- 1. D1 Retention
-- Measures the percentage of users who returned exactly
-- one day after their first activity.

WITH first_activity AS (
    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_activity_date
    FROM ecommerce_events
    GROUP BY user_id
),

eligible_users AS (
    SELECT *
    FROM first_activity
    WHERE first_activity_date <= '2020-02-28'
),

retained_users AS (
    SELECT DISTINCT
        f.user_id
    FROM eligible_users f
    JOIN ecommerce_events e
        ON f.user_id = e.user_id
        AND DATE(e.event_time) =
            DATE_ADD(f.first_activity_date, INTERVAL 1 DAY)
)

SELECT
    COUNT(*) AS eligible_users,
    (SELECT COUNT(*) FROM retained_users) AS d1_retained_users,

    ROUND(
        (SELECT COUNT(*) FROM retained_users) * 100.0 /
        COUNT(*),
        2
    ) AS d1_retention_rate

FROM eligible_users;


-- 2. D7 Retention
-- Measures the percentage of users who returned exactly
-- seven days after their first activity.

WITH first_activity AS (
    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_activity_date
    FROM ecommerce_events
    GROUP BY user_id
),

eligible_users AS (
    SELECT *
    FROM first_activity
    WHERE first_activity_date <= '2020-02-22'
),

retained_users AS (
    SELECT DISTINCT
        f.user_id
    FROM eligible_users f
    JOIN ecommerce_events e
        ON f.user_id = e.user_id
        AND DATE(e.event_time) =
            DATE_ADD(f.first_activity_date, INTERVAL 7 DAY)
)

SELECT
    COUNT(*) AS eligible_users,
    (SELECT COUNT(*) FROM retained_users) AS d7_retained_users,

    ROUND(
        (SELECT COUNT(*) FROM retained_users) * 100.0 /
        COUNT(*),
        2
    ) AS d7_retention_rate

FROM eligible_users;

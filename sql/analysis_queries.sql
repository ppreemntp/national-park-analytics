USE national_park_analytics;

-- Top 10 national parks by total visitors
-- Use complete calendar years only: 2018-2024

SELECT
    park_name,
    province,
    SUM(visitors) AS total_visitors,
    ROUND(AVG(visitors), 0) AS avg_monthly_visitors
FROM vw_park_monthly
WHERE calendar_year_ce BETWEEN 2018 AND 2024
GROUP BY
    park_id,
    park_name,
    province
ORDER BY total_visitors DESC
LIMIT 10;

-- Monthly seasonality
-- Compare visitors, rainfall, and park availability by month
-- Complete calendar years: 2018-2024

SELECT
    month_num,
    month_th,
    ROUND(AVG(visitors), 0) AS avg_visitors,
    ROUND(AVG(avg_rain), 2) AS avg_rain,
    ROUND(AVG(availability_pct), 2) AS avg_availability_pct
FROM vw_park_monthly
WHERE calendar_year_ce BETWEEN 2018 AND 2024
GROUP BY
    month_num,
    month_th
ORDER BY month_num;
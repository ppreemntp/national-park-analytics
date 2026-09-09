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



-- Yearly visitor trend
-- Complete calendar years only: 2018-2024

SELECT
    calendar_year_ce,
    SUM(visitors) AS total_visitors
FROM vw_park_monthly
WHERE calendar_year_ce BETWEEN 2018 AND 2024
GROUP BY calendar_year_ce
ORDER BY calendar_year_ce;


-- Top 10 low-rain national parks in July
-- Complete calendar years only: 2018-2024

SELECT
    park_name,
    province,
    ROUND(AVG(avg_rain), 2) AS avg_rain,
    ROUND(AVG(visitors), 0) AS avg_visitors,
    ROUND(AVG(availability_pct), 2) AS avg_availability_pct
FROM vw_park_monthly
WHERE calendar_year_ce BETWEEN 2018 AND 2024
    AND month_num = 7
GROUP BY
    park_id,
    park_name,
    province
ORDER BY avg_rain ASC



-- Park-month profile for seasonal recommendation
-- Uses complete calendar years: 2018-2024

CREATE OR REPLACE VIEW vw_park_monthly_profile AS
SELECT
    park_id,
    park_name,
    province,
    office,
    month_num,
    month_th,

    ROUND(AVG(visitors), 2) AS avg_visitors,
    ROUND(AVG(avg_rain), 2) AS avg_rain,
    ROUND(AVG(availability_pct), 2) AS avg_availability_pct,

    COUNT(*) AS records_used

FROM vw_park_monthly

WHERE calendar_year_ce BETWEEN 2018 AND 2024

GROUP BY
    park_id,
    park_name,
    province,
    office,
    month_num,
    month_th;


    CREATE OR REPLACE VIEW vw_park_recommendation AS
SELECT
    *,
    DENSE_RANK() OVER (
        PARTITION BY month_num
        ORDER BY suitability_score DESC
    ) AS recommendation_rank
FROM vw_park_suitability
WHERE suitability_score IS NOT NULL;


SELECT
    recommendation_rank,
    park_name,
    province,
    avg_rain,
    avg_visitors,
    avg_availability_pct,
    suitability_score
FROM vw_park_recommendation
WHERE month_num = 7
ORDER BY recommendation_rank
LIMIT 10;
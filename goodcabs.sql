/* Goodcabs, a cab service company established two years ago, has gained a strong foothold in the indian market by focusing 
   on tier-2 cities. Unlike other cab service providers, Goodcabs is committed to supporting local drivers, helping them make 
   sustainable living in their hometowns while ensuring service to passengers. With operations in ten tier- cities across India, 
   Goodcabs has set ambitions performance targets for 2024 to drive growth and improve passenger satisfaction. 
   
   This script includes analyses for:
1. City-Level Fare and Trip Summary: Insights into city-level trip performance and fare metrics.
2. Monthly City-Level Performance: Evaluating trip targets and performance status.
3. Repeat Passenger Frequency: Understanding passenger retention across cities.
4. Cities with Highest/Lowest New Passengers: Identifying top-performing and struggling cities.
5. Monthly Revenue Analysis: Finding the month with highest revenue contribution for each city.
6. Repeat Passenger Rate Analysis: Assessing passenger loyalty trends at monthly and overall levels.
*/



-- Business Request 1: City-Level Fare and Trip Summary Report
SELECT 
    c.city_name,
    COUNT(t.trip_id) AS total_trips,
    ROUND(SUM(t.fare_amount) / SUM(t.distance_travelled_km), 2) AS avg_fare_per_km,
    ROUND(SUM(t.fare_amount) / COUNT(t.trip_id), 2) AS avg_fare_per_trip,
    CONCAT(FORMAT((COUNT(t.trip_id) / (SELECT COUNT(trip_id) FROM trips_db.fact_trips)) * 100, 2), '%') AS percentage_contribution_to_total_trips
FROM 
    trips_db.fact_trips t
JOIN 
    trips_db.dim_city c ON t.city_id = c.city_id
GROUP BY 
    c.city_name
ORDER BY 
    total_trips DESC;

    
    
-- Business Request 2: Monthly City-Level Trips Target Performance Report
SELECT 
    c.city_name,
    d.month_name,
    COUNT(t.trip_id) AS actual_trips,
    mt.total_target_trips AS target_trips,
    CASE 
        WHEN COUNT(t.trip_id) > mt.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    CONCAT(ROUND((COUNT(t.trip_id) - mt.total_target_trips) / mt.total_target_trips * 100, 2), '%') AS percentage_difference
FROM 
    trips_db.fact_trips t
JOIN 
    trips_db.dim_city c ON t.city_id = c.city_id
JOIN 
    trips_db.dim_date d ON t.date = d.date
JOIN 
    targets_db.monthly_target_trips mt ON t.city_id = mt.city_id AND d.start_of_month = mt.month
GROUP BY 
    c.city_name, d.month_name, mt.total_target_trips
ORDER BY 
    d.month_name, c.city_name;

    
    
-- Business Request 3: City-Level Repeat Passenger Trip Frequency Report [please check if only 9 trips are there]
SELECT 
    c.city_name,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 2 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `2-Trips`,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 3 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `3-Trips`,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 4 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `4-Trips`,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 5 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `5-Trips`,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 6 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `6-Trips`,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 7 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `7-Trips`,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 8 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `8-Trips`,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 9 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `9-Trips`,
    CONCAT(ROUND(SUM(CASE WHEN r.trip_count = 10 THEN r.repeat_passenger_count ELSE 0 END) / SUM(r.repeat_passenger_count) * 100, 2),'%') AS `10-Trips`
FROM 
    trips_db.dim_repeat_trip_distribution r
JOIN 
    trips_db.dim_city c ON r.city_id = c.city_id
GROUP BY 
    c.city_name;



-- Business Request 4: Identify Cities with Highest and Lowest Total New Passengers
WITH RankedCities AS (
    SELECT 
        c.city_name,
        SUM(ps.new_passengers) AS total_new_passengers,
        RANK() OVER (ORDER BY SUM(ps.new_passengers) DESC) AS descending_rank,
        RANK() OVER (ORDER BY SUM(ps.new_passengers) ASC) AS ascending_rank
    FROM 
        trips_db.fact_passenger_summary ps
    JOIN 
        trips_db.dim_city c ON ps.city_id = c.city_id
    GROUP BY 
        c.city_name
)
SELECT 
    city_name,
    total_new_passengers,
    CASE 
        WHEN descending_rank <= 3 THEN 'Top 3'
        WHEN ascending_rank <= 3 THEN 'Bottom 3'
    END AS city_category
FROM 
    RankedCities
WHERE 
    descending_rank <= 3 OR ascending_rank <= 3;



-- Business Request 5: Identify Month with Highest Revenue for Each
WITH CityMonthlyRevenue AS (
    SELECT 
        c.city_name,
        d.month_name,
        SUM(t.fare_amount) AS monthly_revenue
    FROM 
        trips_db.fact_trips t
    JOIN 
        trips_db.dim_city c ON t.city_id = c.city_id
    JOIN 
        trips_db.dim_date d ON t.date = d.date
    GROUP BY 
        c.city_name, d.month_name
),
RankedCityRevenue AS (
    SELECT 
        city_name,
        month_name,
        monthly_revenue,
        ROW_NUMBER() OVER (PARTITION BY city_name ORDER BY monthly_revenue DESC) AS revenue_rank,
        SUM(monthly_revenue) OVER (PARTITION BY city_name) AS total_revenue
    FROM 
        CityMonthlyRevenue
)
SELECT 
    city_name,
    month_name AS highest_revenue_month,
    monthly_revenue,
    CONCAT(ROUND((monthly_revenue / total_revenue) * 100, 2),'%') AS percentage_contribution
FROM 
    RankedCityRevenue
WHERE 
    revenue_rank = 1;



-- Business Request 6: Repeat Passenger Rate Analysis
SELECT 
    c.city_name,
    d.month_name,
    ps.total_passengers,
    ps.repeat_passengers,
    CONCAT(ROUND(ps.repeat_passengers / ps.total_passengers * 100, 2),'%') AS monthly_repeat_passenger_rate
FROM 
    trips_db.fact_passenger_summary ps
JOIN 
    trips_db.dim_city c ON ps.city_id = c.city_id
JOIN 
    trips_db.dim_date d ON ps.month = d.start_of_month;
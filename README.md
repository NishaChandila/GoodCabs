# Goodcabs: Data Analysis Project

~ "In every journey lies a promise—to get people where they need to be, safely and reliably."

## **INTRODUCTION**

This project focuses on Goodcabs, a cab service dedicated to transforming mobility in tier-2 cities across India. Goodcabs stands out not only for its commitment to reliable transportation but also for empowering local drivers to earn sustainable livelihoods in their hometowns. With ambitious goals set for 2024, this analysis seeks to uncover data-driven insights to enhance operational efficiency, improve passenger satisfaction, and achieve growth objectives.

The primary aim of this project is to answer critical business questions using SQL analysis and provide actionable insights through an interactive Power BI dashboard. Key metrics such as trip volumes, revenue trends, and passenger behavior are analyzed to identify city-level performance, seasonal demand patterns, and growth opportunities. The analysis emphasizes both primary questions—like identifying top-performing cities and improving repeat passenger retention—and secondary questions, such as understanding seasonal demand shifts and optimizing fare structures.

By leveraging Python, SQL, and Power BI, this project transforms raw data into meaningful stories, presenting stakeholders with a comprehensive view of Goodcabs’ operations. The ultimate goal is to identify strengths, address challenges, and support strategic decision-making, ensuring that Goodcabs not only meets its 2024 targets but also strengthens its impact in the communities it serves.

- [Dataset here](https://github.com/NishaChandila/GoodCabs/tree/main/Dataset)

- [Power BI Dashboard](https://github.com/NishaChandila/GoodCabs/blob/main/goodcabs-dashboard.pdf)

- SQL Business Questions [Ad-hoc here](https://github.com/NishaChandila/GoodCabs/blob/main/goodcabs.sql)

- Python Primary & Secondary Question [Here]()

- Goodcabs Presentation [Here](https://github.com/NishaChandila/GoodCabs/blob/main/GoodCabs-Presentation.pdf)

---

## **DATA STRUCTURE**


# **DATASET PREVIEW**

![Dataset](https://github.com/NishaChandila/project-assets/blob/main/goodcabs-dataset.PNG)

### 1. dim_city.csv
- **city_id**: A unique identifier for each city.
- **city_name**: Name of the city where Goodcabs operates.

### 2. dim_date.csv
- **start_of_month**: The first date of each month for grouping and time-based analysis.
- **month_name**: The full name of the month (e.g., January, February) for readability.
- **day_type**: Categorizes days as weekday or weekend to analyze demand patterns.
- **date**: Specific calendar date for precise trip tracking.

### 3. dim_repeat_trip_distribution.csv
- **city_id**: Links data to a specific city.
- **month**: The month of the record in "DD MMM YYYY" format.
- **repeat_passenger_count**: Number of passengers who took multiple trips in a month.
- **trip_count**: Total trips (including repeat and new trips) in the same period.

### 4. city_target_passenger_rating.csv
- **city_id**: Identifies the city.
- **target_passenger_rating**: Target passenger satisfaction rating set for the city.

### 5. fact_passenger_summary.csv
- **city_id**: Identifies the city for passenger data.
- **month**: The time period in "DD MMM YYYY" format.
- **new_passengers**: Count of first-time passengers in a month.
- **repeat_passengers**: Number of passengers who returned for additional trips.
- **total_passengers**: Combined total of new and repeat passengers.

### 6. fact_trips.csv
- **trip_id**: Unique identifier for each trip.
- **city_id**: City where the trip occurred.
- **date**: The exact date of the trip.
- **passenger_type**: Indicates whether the passenger is new or repeat.
- **distance_travelled(km)**: Total distance covered during the trip (in kilometers).
- **fare_amount**: Fare charged for the trip.
- **passenger_rating**: Rating given by the passenger for the trip (1 to 5).
- **driver_rating**: Rating given by the driver for the passenger (1 to 5).

### 7. monthly_target_new_passengers.csv
- **city_id**: Links target data to specific cities.
- **month**: The month of the record in "DD MMM YYYY" format.
- **target_new_passengers**: Targeted number of new passengers for the month.

### 8. monthly_target_trips.csv
- **city_id**: Identifier for each city.
- **month**: The month of the record in "DD MMM YYYY" format.
- **total_target_trips**: Target number of trips Goodcabs aims to achieve.

- Key performance metrics include total trips, revenue trends, repeat passenger rates, and more.

- [Dataset here](https://github.com/NishaChandila/GoodCabs/tree/main/Dataset)

---

## **EXECUTIVE SUMMARY**

This analysis focuses on providing Goodcabs with a comprehensive understanding of its operations, performance, and growth potential by leveraging SQL queries and Power BI visualizations. The insights gained are based on key metrics across multiple cities and months, designed to help Goodcabs optimize its strategies, improve passenger retention, and drive growth in tier-2 cities.

### **SQL Analysis**
SQL queries were used to examine core business questions, revealing critical insights about Goodcabs' performance across different cities and months. Key findings include:

- **City-Level Fare and Trip Summary**: 
  - Total trips: 425.9K (Jaipur with 77K trips, Mysore with 16.2K trips).
  - Fare per trip: Jaipur at ₹484, Mysore at ₹249.71.
  
- **Monthly Target Performance**: 
  - Coimbatore, Jaipur, and Kochi exceeded their trip targets, while cities like Chandigarh and Vadodara fell short.

- **Repeat Passenger Analysis**:
  - Highest repeat passenger rate: Visakhapatnam at 51%, lowest: Lucknow.
  - Average repeat passenger rate: 25.73%.

- **New Passenger Trends**: 
  - Jaipur attracted the highest number of new passengers (45.86K), while Coimbatore had the lowest (8.5K).

- **Revenue Performance by Month**:
  - Chandigarh saw peak revenue of ₹2.1M in February, while June saw a decline in both trips and revenue.

- SQL Business Questions [Ad-hoc here](https://github.com/NishaChandila/GoodCabs/blob/main/goodcabs.sql)

---

## **POWER BI DASHBOARD**

The Power BI dashboard is designed to offer clear and actionable insights into Goodcabs’ operations. It includes two pages: **Overview** and **Performance**.

![Home](https://github.com/NishaChandila/project-assets/blob/main/goodcabs-1.PNG)

### **Page 1: Overview**
This page presents a high-level snapshot of key performance metrics:
- **Total Trips**: 425.9K trips.
- **Total Distance Traveled**: 8M km.
- **Total Fare Collected**: ₹108M.
- **Repeat Passenger Rate**: 25.73%.
- **New vs Repeat Passenger Ratio**: 74.27% new, 25.73% repeat.
- **Average Driver Rating**: 7.83.

![Overview](https://github.com/NishaChandila/project-assets/blob/main/goodcabs-2.PNG)

Key charts include city-wise comparisons, revenue growth, and total trips by month.

### **Page 2: Performance**
The Performance page dives deeper into city-level performance:

![Performance](https://github.com/NishaChandila/project-assets/blob/main/goodcabs-3.PNG)

- **Average Trip Distance by Month**: Highest in January at 19.6 km.
- **Average Trip Distance by City**: Jaipur (30 km), Surat (11 km).
- **Monthly Average Fare per Trip**: February ₹263.5, January ₹261.9.
- **New vs Repeat Trips by Month**: January saw the highest new trips (36K), while May had the lowest repeat trips (48K).

- [Power BI Dashboard](https://github.com/NishaChandila/GoodCabs/blob/main/goodcabs-dashboard.pdf)

---

## **PRIMARY AND SECONDARY INSIGHTS**

### **Primary Insights**:
- **City Performance vs. Monthly Targets**: Assess city-level performance and identify improvement areas.
- **Repeat Passenger Rates & Retention**: Focus on improving repeat passenger rates for better retention.

### **Secondary Insights**:
- **City Contribution to Trips & Revenue**: Identify key cities contributing the most to trips and revenue.
- **Seasonal Demand Patterns**: Understand seasonal trends and their impact on revenue and trips.

- Python Primary & Secondary Question [Here]()

---

## **RECOMMENDATIONS**

Based on insights from SQL analysis and the Power BI dashboard, the following key recommendations aim to enhance Goodcabs' performance and customer retention:

- **Target Underperforming Cities**: Focus on Surat and Vadodara, with low trip numbers (21K and 16K, respectively), to improve trips and revenue through targeted marketing and operational strategies.
- **Improve Retention**: With 74.27% of trips coming from new passengers, introduce loyalty programs to boost repeat business.
- **Address Seasonal Demand Fluctuations**: Mitigate the decline in trips during June (15% revenue drop) with promotions and adjusted marketing during off-peak months.
- **Replicate Best Practices from High-Performing Cities**: Scale success in cities like Jaipur (77K trips, ₹484 average fare) to other regions.
- **Adjust Fare Strategy**: Consider adjusting fare structures in cities with lower fare averages like Surat (₹117) and Vadodara (₹119).
- **Enhance Monthly Tracking**: Improve performance forecasting through more detailed monthly analysis of trips, revenue, and passenger types.
- **Boost New Passenger Growth**: Focus on increasing new passengers in underperforming cities like Coimbatore (21K trips).

By implementing these strategies, Goodcabs can drive operational efficiency, increase revenue, and improve customer retention, ensuring long-term success and growth in tier-2 cities.

- [Dataset here](https://github.com/NishaChandila/GoodCabs/tree/main/Dataset)

- [Power BI Dashboard](https://github.com/NishaChandila/GoodCabs/blob/main/goodcabs-dashboard.pdf)

- SQL Business Questions [Ad-hoc here](https://github.com/NishaChandila/GoodCabs/blob/main/goodcabs.sql)

- Python Primary & Secondary Question [Here]()

- Goodcabs Presentation [Here](https://github.com/NishaChandila/GoodCabs/blob/main/GoodCabs-Presentation.pdf)

---

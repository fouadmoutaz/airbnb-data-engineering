# Airbnb Data Analysis Project

Welcome to the Airbnb Data Analysis Project README! This document serves as a central reference point for understanding the entire project, including the dataset, ETL pipeline, data warehouse schema, and business questions answered. Let's dive into the details:

## Project Presentation

![https://www.canva.com/design/DAF9ztWC6fY/mbPyceUascIDx7yqVy-5-A/edit?utm_content=DAF9ztWC6fY&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton](presentation.png)

https://www.canva.com/design/DAF9ztWC6fY/mbPyceUascIDx7yqVy-5-A/edit?utm_content=DAF9ztWC6fY&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton


![pipeline](pipeline.png)

## [Source Data](./1.%20Source%20Data/README.md)

**Dataset Name**: Airbnb Listings, Reviews, and Calendar Data For Barcelona, Spain

**Description**: This dataset contains comprehensive information about Airbnb listings in Barcelona, including details about properties, host information, availability, reviews, and calendar data. It serves as the foundation for various analyses aimed at understanding pricing trends, property popularity, host behavior, and more.


## [Airbnb Data Warehouse (DWH)](./2.%20DWH/README.md)

### Schema Overview
![DWH.png](./2.%20DWH/DWH.png)
The Airbnb Data Warehouse (DWH) schema consists of fact and dimension tables designed to centralize and organize Airbnb's operational data for analytical purposes. Here's an overview:

#### Fact Tables:

1. **calendar_Fact**: Stores availability and pricing information for Airbnb listings.
2. **review_Fact**: Contains data related to guest reviews of Airbnb listings.

#### Dimension Tables:

1. **date_Dim**: Provides date-related attributes for temporal analysis.
2. **listing_Dim**: Stores detailed information about Airbnb listings for contextual analysis.

### Rationale for Choosing Fact and Dimension Tables

Fact tables were chosen based on their representation of key operational aspects of Airbnb's data, while dimension tables provide context and descriptive attributes for analysis.

## [ETL Pipeline](./3.%20ETL%20Pipeline/README.md)

The ETL (Extract, Transform, Load) pipeline extracts data from the staging layer in SQL Server, performs necessary transformations using Python, and loads the transformed data into a SQL Server database. The pipeline involves the following steps:

1. **Extract**: Data is extracted from the staging layer in SQL Server, including tables such as `calendar`, `listings`, and `reviews`.

2. **Transform**: Python and pandas are used to perform transformations, including date dimension table creation, cleaning and formatting, and filtering and column selection.

3. **Load**: Transformed data is loaded into the destination SQL Server database (`Airbnb_DWH`) using SQLAlchemy.
## [Business Questions](./4.%20Business%20Questions/README.md)

This section provides answers to specific business questions based on the Airbnb Data Warehouse (DWH) after the ETL process and modeling. Each question is answered using SQL queries against the DWH tables, covering various aspects such as listing availability, pricing, reviews, and neighborhood analysis.

Example of the analysis:
Question: 
### Q.4: Recommendations for Vacationers

#### For a Man with His Wife and 2 Children Looking for a Week Vacation around March 2024:
```sql
WITH AvailableDays AS (
    SELECT
        c.listing_id,
        d.date,
        ROW_NUMBER() OVER (PARTITION BY c.listing_id ORDER BY d.date) AS rn
    FROM calendar_Fact c
    JOIN date_Dim d ON c.date_key = d.date_key
    WHERE d.year = 2024 AND d.month = 3 AND c.available = 1 
),
ConsecutiveDays AS (
    SELECT
        listing_id,
        MIN(date) AS start_date,
        MAX(date) AS end_date,
        COUNT(*) AS available_days
    FROM AvailableDays
    GROUP BY listing_id, DATEADD(day, -rn, date)
)
SELECT TOP 3 c.listing_id, name, accommodates, available_days, price
FROM ConsecutiveDays c
JOIN listing_Dim l
ON l.listing_id = c.listing_id
WHERE available_days >= 7 AND accommodates >=4 AND name LIKE '%2 bedrooms%4 beds%'
ORDER BY price,available_days DESC, start_date ASC;
```
## Conclusion

The Airbnb Data Analysis Project README provides a comprehensive overview of the project, from data extraction and transformation to schema design and business question answers. It serves as a guide for understanding the project's objectives, methodologies, and outcomes.

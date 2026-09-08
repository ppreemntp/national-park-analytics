# Thailand National Park Seasonal Analytics

A data analytics and data engineering project for analyzing Thai national parks by combining tourism, rainfall, and park availability data.

## Project Objective

The project aims to answer:

> Which national parks are suitable to visit during different months of the year based on rainfall, visitor volume, and park availability?

## Data Sources

- National park visitor statistics
- Monthly provincial rainfall data
- National park location data
- National park open/close information

## Project Workflow

1. Data collection
2. Data cleaning
3. Data transformation
4. Data integration
5. Database design
6. SQL analysis
7. Power BI dashboard
8. Seasonal recommendation analysis

## Tech Stack

- Python
- Pandas
- Matplotlib
- MySQL
- SQL
- Power BI
- Jupyter Notebook

## Database Design

The project uses a star-schema style database:

- `dim_park`
- `dim_date`
- `fact_park_monthly`
- `vw_park_monthly`

## Current Status

- [x] Tourism data preparation
- [x] Rainfall data preparation
- [x] Park location mapping
- [x] Park availability processing
- [x] Integrated master dataset
- [x] MySQL database setup
- [x] Star schema design
- [ ] SQL analytics
- [ ] Power BI dashboard
- [ ] Seasonal recommendation score
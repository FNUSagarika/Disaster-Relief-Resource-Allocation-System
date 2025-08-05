# Disaster-Relief-Resource-Allocation-System

This project demonstrates a relational database model designed to support efficient disaster response and resource allocation for humanitarian organizations. It uses real-world disaster data from EM-DAT [https://www.emdat.be/] along with simulated relief inventory and distribution records to enable data-driven decision-making during emergencies.

## Project Objectives
- Normalize and design an end-to-end relational database schema for disaster event tracking and relief management
- Implement the schema using SQL in Databricks with Delta Lake for scalable, ACID-compliant data storage
- Analyze and visualize key metrics such as disaster impact, supply-demand mismatches, and resource distribution patterns

## Project Structure
- `ER_Diagram` – Entity Relationship Diagram (conceptual model)
- `Physical_Model` – Overview of data types, keys, partitioning, and Delta Lake strategy
- `Schema` – SQL code to create tables in Databricks
- `Business_queries` – Analytical queries to extract insights from the database
- `Dashboard_screenshots/` – Sample output visualizations used for insights

## Technologies Used
- SQL (Databricks SQL)
- Delta Lake (for ACID-compliant data storage)
- EM-DAT (The Emergency Events Database) [https://www.emdat.be/]
- Simulated Relief Inventory Data
- Visualization tools (Databricks)

## Key Business Insights
- Identified top disaster types by event frequency and economic damage
- Analyzed mismatches between relief resources requested and delivered
- Highlighted high-fatality disaster events and under-resourced regions

## Sample Business Insights
- Storms account for over 65% of disasters and economic damage
- Significant resource under-supply identified for volcanic activity and industrial collapses
- Food packs and blankets are the most requested items during floods and storms
  
## Future Scope
- Integrate live data from weather APIs and UN OCHA feeds
- Build a dashboard to monitor real-time allocation and resource gaps
- Apply ML for predictive modeling of relief needs based on past events


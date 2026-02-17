# Sales Data Analysis – SQL Business Intelligence Project
## Project Overview
This project implements a Business Intelligence (BI) solution using SQL Server for a retail bike sales company. The goal is to transform raw transactional data into actionable business insights through a structured data model, KPI-focused views, and reusable stored procedures.

The project simulates a real-world analytics workflow, starting from schema design and data ingestion to performance reporting and decision support.

![Dashboard Preview](diagram/image_diagram.png)

**Description:**

This ER diagram represents the normalized relational database schema for the Bike Store sales system.
The schema is designed to support transactional sales analysis, inventory tracking, and staff performance reporting.

## Project Objectives
- Build a normalized relational database for retail sales data
- Load and transform CSV-based data using bulk insert techniques
- Design KPI-driven SQL views for reporting and analytics
- Implement stored procedures to support reusable and automated analysis
- Enable management-level insights for sales, inventory, staff, and regional performance

## Dataset
The dataset represents a bike retail chain and includes the following entities:

- Sales and Orders
- Order Items
- Customers
- Products
- Stores
- Inventory (Stocks)
- Staff
- Brands and Categories
  
**Note:**
The dataset included in this repository is a sample dataset used to demonstrate the data model and SQL logic. Full production data is excluded for confidentiality reasons.

# KPIs & Analytical Views

## Store Performance

- vw_StoreSalesSummary
Revenue, number of orders, and Average Order Value (AOV) per store



















# Python-SQL-Project 
# ETL-Project

# 🗃️ SQL Server + Python Integration Project

This project demonstrates how to use **Microsoft SQL Server** for database operations and connect it with **Python** for data extraction, manipulation, and analysis.

## 📂 Files Included

## 📥 Download Sample Output

You can download the result CSV directly here:

[![Download CSV](https://img.shields.io/badge/Download-CSV-blue.svg)](orders.csv)

- `SQLQuery1_2.sql`  
  Contains SQL scripts for:
  - Creating database/tables
  - Performing CRUD operations
  - Executing queries
  - **Common Table Expressions (CTEs)**

- `Python+SQL.ipynb`  
  A Jupyter Notebook showcasing:
  - Connecting Python to MS SQL Server
  - Running SQL queries using Python (via `pyodbc` or similar)
  - Fetching and analyzing data using Pandas

## ⚙️ Technologies Used

- MS SQL Server
- SQL Server Management Studio (SSMS)
- Python 3.x
- Jupyter Notebook
- ### 🐍 Python Libraries:
- `sqlalchemy`
- `pyodbc`
- `pandas`

## 🚀 How to Use

1. Open and run `SQLQuery1_2.sql` in **SSMS** to create and populate the database.
2. Ensure your SQL Server instance is running and accessible.
3. Open `Python+SQL.ipynb` in **Jupyter Notebook**.
4. Update the connection string with your SQL Server credentials.
5. Run the notebook cells to execute and analyze SQL queries from Python.

## 📈 Project Objectives

- Practice SQL querying in MS SQL Server.
- Integrate SQL database with Python for analytics.
- Demonstrate real-time database interactions from Python.

## 📌 Notes

- You may need to install required Python libraries using:
  ```bash
  pip install pyodbc pandas sqlalchemy

# Complete-Healthcare-SQL-Project

# 🏥 Healthcare Analytics SQL Project (MySQL)

A complete end-to-end SQL project designed for realistic **healthcare data analysis**.  
This project includes a relational database schema, 600+ rows of clean sample data,  
and 25+ analytical SQL queries ranging from beginner to advanced.

---

## 📌 Project Overview

This project simulates a real healthcare scenario involving:

- Patients  
- Doctors  
- Medical Appointments  
- Diagnosis Records  
- Treatments  
- Billing & Payments  

The goal is to analyze patient care efficiency, doctor performance, hospital revenue,  
and overall healthcare operations using **MySQL queries**.

---

## 🗂 Database Structure (ER Diagram Overview)

**Entities:**
- `patients`  
- `doctors`  
- `appointments`  
- `diagnosis`  
- `treatments`  
- `billing`

**Relationships:**
- One patient can have many appointments  
- One doctor can treat many patients  
- One appointment can have multiple diagnosis records  
- Every treatment generates a billing entry  

---

## 📁 Folder Structure

Healthcare_SQL_Project/
├── data/
│ ├── patients.csv
│ ├── doctors.csv
│ ├── appointments.csv
│ ├── diagnosis.csv
│ ├── treatments.csv
│ └── billing.csv
│
├── sql/
│ ├── create_tables.sql
│ ├── insert_data.sql
│ └── analysis_queries.sql
│
└── README.md



---

## 🛠 Tech Stack

- **MySQL 8+**
- CSV Dataset (600+ rows)
- SQL Analytics (Joins, CTEs, Window Functions, Subqueries)

---

## 🚀 How to Run This Project

### 1️⃣ Create Database
```sql
CREATE DATABASE healthcare_db;
USE healthcare_db;



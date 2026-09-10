# Hospital Patient Care Operations Analysis 🏥📊

## 📌 Project Overview

**Hospital Patient Care Operations Analysis** is a MySQL-based database and data analytics project focused on analyzing hospital patient-care operations and generating meaningful insights using SQL.

The project uses a relational database designed for **CarePlus Hospital**. It manages patients, doctors, rooms, appointments, and treatments while maintaining relationships through primary keys and foreign keys.

The analysis focuses on patient demand, appointment patterns, treatment performance, doctor workload, room/equipment utilization, and operational problem areas.

---

## 🎯 Project Objectives

- Design and implement a relational hospital database using MySQL.
- Create interconnected tables for hospital operations.
- Establish relationships using Primary Keys (PK) and Foreign Keys (FK).
- Maintain data integrity across related tables.
- Analyze hospital operations using SQL queries.
- Identify important patterns and trends in patient care operations.
- Generate business-oriented insights to support operational decision-making.

---

## 🗄️ Database Structure

The database contains **5 interconnected tables**:

| Table | Purpose |
|---|---|
| `patients` | Stores patient details, demographics, city, patient type, and registration information. |
| `doctors` | Stores doctor details, specialty, rating, employment type, and active status. |
| `rooms` | Stores room type, floor, equipment, capacity, maintenance, and availability information. |
| `appointments` | Stores appointment details including patient, doctor, service, priority, cost, and booking channel. |
| `treatments` | Stores treatment details including appointment, doctor, room, status, attempts, duration, waiting time, and cost. |

### 🔗 Main Relationships

- **Patients → Appointments** — A patient can have multiple appointments.
- **Doctors → Appointments** — A doctor can handle multiple appointments.
- **Appointments → Treatments** — An appointment can have treatment records.
- **Doctors → Treatments** — A doctor can perform multiple treatments.
- **Rooms → Treatments** — A room can be used for multiple treatments.

---

## 🔗 Entity Relationship Diagram

The ER diagram represents the database tables and their relationships.

![Hospital ER Diagram](ER_Diagram/Hospital_ER_Diagram.png)

---

## 📊 Key Analysis Questions

### 👥 Patient & Appointment Analysis

- What is the total number of patients?
- What is the total number of appointments?
- What is the total estimated appointment value?
- Which cities have the highest appointment volume?
- Which service types are most frequently requested?
- How are appointments distributed by priority?
- How does appointment volume change over time?
- Which booking channels contribute the most appointments?
- Which patients have the highest number of appointments?
- Which patients have the highest cumulative estimated appointment value?

### 🏷️ Patient Type Analysis

- How do General, Corporate, and Insurance patients compare?
- Which patient type has the highest appointment volume?
- What is the estimated appointment value for each patient type?

### 🩺 Treatment Performance Analysis

- What is the average treatment duration?
- What is the average waiting time for different treatment statuses?
- Which treatment statuses occur most frequently?
- Which cities have the highest number of treatments?
- Which cities have problematic treatment outcomes?
- How do treatment outcomes change over time?
- How does priority relate to treatment outcomes?

### 👨‍⚕️ Doctor Analysis

- Which doctors have the highest number of treatments?
- How many completed treatments does each doctor have?
- How does doctor performance vary by treatment outcome?
- What is the average treatment duration for each doctor?

### 🏥 Room & Equipment Analysis

- Which room types are used most frequently?
- Which equipment types are utilized the most?
- What is the treatment volume by room type?
- How do treatment duration and waiting time vary by room type?

### ⚠️ Operational Problem Analysis

- Which appointments required multiple treatment attempts?
- How many appointments required more than one treatment attempt?
- Which treatment statuses indicate operational problems?
- How does waiting time vary by treatment attempt?
- Which cities have the highest number of problematic treatments?

---

## 🛠️ SQL Concepts Used

This project demonstrates practical usage of:

- `SELECT`
- `WHERE`
- `JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- `COUNT()`
- `COUNT(DISTINCT ...)`
- `SUM()`
- `AVG()`
- `ROUND()`
- `CASE`
- `IN`
- Subqueries
- Date functions
- `DATE_FORMAT()`
- Aggregate functions
- Primary Keys
- Foreign Keys

---

## 🔍 Analysis Approach

```text
Business Question
       ↓
Identify Required Tables
       ↓
Join Related Data
       ↓
Filter / Group Data
       ↓
Apply Aggregate Functions
       ↓
Sort & Compare Results
       ↓
Generate Business Insight
```

This approach helped convert structured hospital data into useful operational information.

---

## 💡 Key Findings

Based on the project analysis:

- **Delhi** had the highest appointment volume.
- Appointment demand varied across service types and priority levels.
- Appointment volume showed variation across different months.
- **General patients** had the highest patient and appointment volume.
- **Completed treatments** were the most common treatment outcome.
- Doctor workload and treatment counts varied across doctors.
- Room utilization varied across different room types.
- Equipment usage varied across treatment records.
- **500 appointments required multiple treatment attempts**, highlighting an area that can be investigated for operational improvement.

---

## 📈 Business Insights

### 1. Improve Appointment Scheduling

High-demand cities, services, and time periods can be monitored to improve appointment scheduling and resource allocation.

### 2. Optimize Doctor Workload

Doctor-level treatment counts and performance can help identify workload differences and support better resource planning.

### 3. Improve Room Utilization

Room type and equipment usage analysis can help management understand utilization patterns and improve room allocation.

### 4. Monitor Operational Problems

Cancellations, no-shows, rescheduled appointments, and multiple treatment attempts can be monitored to identify areas requiring operational attention.

### 5. Understand Patient Behavior

High-frequency and high-value patients can be analyzed to better understand appointment behavior and demand patterns.

### 6. Analyze Priority-Based Outcomes

Comparing appointment priority with treatment outcomes can help identify patterns in patient-care operations.

---

## 🧰 Tools & Technologies

- **MySQL**
- **SQL**
- **Relational Database Design**
- **Data Analysis**

---

## 📁 Repository Structure

```text
Hospital-Patient-Care-Operations-Analysis/
│
├── README.md
│
├── SQL/
│   └── Hospital_Op_Analytics_SQL_Project.sql
│
├── ER_Diagram/
│   └── Hospital_ER_Diagram.png
│
├── Presentation/
│   └── Hospital Patient Care Operations Analysis.pptx
│
└── Screenshots/
    └── SQL_Query_Results.png
```

> **Note:** The `Screenshots` folder is optional. Add query-result screenshots if you want to showcase the analysis visually.

---

## ▶️ How to Run the Project

### Step 1: Install MySQL

Install MySQL Server and MySQL Workbench.

### Step 2: Open the SQL File

Open:

```text
SQL/Hospital_Op_Analytics_SQL_Project.sql
```

in MySQL Workbench.

### Step 3: Create the Database

The SQL script creates and uses the database:

```sql
CREATE DATABASE careplus_hospital;
USE careplus_hospital;
```

### Step 4: Create the Tables

Run the table-creation statements for:

```text
patients
doctors
rooms
appointments
treatments
```

### Step 5: Load the Data

Execute the data-loading statements included in the SQL project.

### Step 6: Run the Analysis Queries

Execute the analysis queries to explore:

- Patient demand
- Appointment trends
- Patient types
- Treatment performance
- Doctor workload
- Room utilization
- Operational problems

---

## 📚 What I Learned

Through this project, I strengthened my understanding of:

- Relational database design
- Primary Key and Foreign Key relationships
- SQL joins
- Aggregate functions
- Grouping and filtering
- Subqueries
- Conditional logic using `CASE`
- Date-based analysis
- Business-oriented SQL problem solving
- Converting structured data into meaningful insights

---

## ⚠️ Challenges Faced

Some of the key challenges during the project included:

- Designing relationships between multiple hospital tables.
- Maintaining data integrity using Primary Keys and Foreign Keys.
- Handling CSV data import and validation.
- Ensuring consistency across related tables.
- Formulating meaningful analytical questions.
- Writing SQL queries to answer real-world operational problems.

---

## 🎯 Key Takeaway

This project helped me understand that **SQL is not just about retrieving data**.

A well-designed relational database combined with SQL analysis can help identify patterns, understand operational problems, and support **data-driven decision-making**.

It was a valuable step in strengthening my SQL and Data Analytics skills.

---

## 👨‍💻 About Me

**Prasanna Panchumarthi**

B.Tech – Computer Science & Engineering

Aspiring **Data Analyst** with an interest in:

- SQL
- MySQL
- Python
- Power BI
- Excel
- Tableau
- Data Analytics

---

## 📌 Project Highlights

```text
🏥 Healthcare Domain
🗄️ 5 Relational Tables
🔗 PK & FK Relationships
📊 SQL-Based Data Analysis
👨‍⚕️ Doctor Performance Analysis
👥 Patient & Appointment Analysis
🏥 Room & Equipment Utilization
⚠️ Operational Problem Analysis
💡 Business Insights
```

---

## 🙏 Acknowledgement

I would like to thank my trainers and mentors for their guidance and support throughout my SQL and Data Analytics learning journey.

Special thanks to:

- **Raghu Ram Aduri Sir**
- **Kalpana Katiki Reddy Mam**
- **Vishwanath Nyathani Sir**
- **Innomatics Research Labs**

---

## ⭐ If You Find This Project Useful

Feel free to explore the SQL queries, database structure, and analysis included in this repository.

**Thank you for visiting this project! 🚀**

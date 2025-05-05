# 🎓 Course Management System

## 📓 Project Overview

Course Management System is a database-driven solution that stores students information, students enrollments courses offered, and instructors for the courses offered and designed to manage the relationships between students, instructors, and courses. It enables tracking of enrollments, grades, and overall course performance. It is Built using PostgreSQL on Aiven and managed through DBeaver.

---

## 🔧 Tech Stack

* PostgreSQL (via [Aiven.io](https://aiven.io/))
* DBeaver (DB GUI)
* Python + Faker (for mock data generation)
* Power BI (for dashboarding)

---

## 🔍 ERD (Entity Relationship Diagram)

![image](https://github.com/user-attachments/assets/f1eb121a-4945-42d4-a7a4-c09b45fcfab3)


## 📂 Instructions to Run the SQL Code

1. Clone the Repo:

```bash
git clone https://github.com/yourusername/course-management-system.git
cd course-management-system
```

2. Set Up the Database in DBeaver or pgAdmin:

```sql
-- Create schema and tables
\i sql/schema.sql

-- Insert sample data
\i data/sample_data.sql
```

3. Explore Queries:

```sql
\i sql/queries.sql
```

---

## 📄 Explanation of the Schema

* **Students**:
- Stores student info that is (student_id, name, email, DOB)
  
* **Instructors**:
- Contains instructor info (instructor_id, name, email)
  
* **Courses**:  
- contains course details with a foreign key referencing to instructors table
  
* **Enrollments**:  
- Connects students to courses and stores grades and enrollment dates

## 🔢 Key Queries

* **Top 3 Students by GPA**
* **Students Enrolled in Courses Taught by 'John Smith'**
* **Students Failing More Than One Course**
* **Average Grade per Course**
* **Students’ Average Grade Across All Courses**


## ⚡ Challenges and Lessons Learned

### 1. Generating data to populate the database with python - faker library
Real world data shows real world uses of the system. Through Faker library I learnt how to add real world data to my database which saved time by 70% compared to manually typing data.

### 2. Ensuring data relationships were correctly enforced using foreign keys
Using primary and foreign keys ensures data integrity in our database. Foreign keys established relationship of the tables.

### 3. Efficient querying on large data using indexes
Indexes in a relational database management system(RDBMS) makes it faster to retrieve records since indexes act as pointers to where data is stored. I learnt how to add and remove indexes in my system.

### 4. Using DBeaver with Aiven
By connecting DBeaver to a managed PostgreSQL on Aiven. I learnt how to securely configure a remote connecction to a cloud based database.

### 5. Writing Efficient SQL Queries
Learnt how to write complex SQL queries using Common Table Expressions(CTEs) that help simplify complex SQL queries. Some queries were complex due to joins, and aggregation but using CTE and Sub queries improved performance significantly.

## 🚀 Future Improvements
- Integrate with Power Bi service to show a real time dashboard
- Automated Data Refresh - Schedule data refresh for live reporting from the PostgreSQL database.

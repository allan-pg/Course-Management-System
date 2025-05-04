# 🎓 Course Management System

## 📓 Project Overview

This Course Management System is a database-driven solution designed to manage the relationships between students, instructors, and courses. It enables tracking of enrollments, grades, and overall course performance. Built using PostgreSQL on Aiven and managed through DBeaver, it includes schema design, data population with Faker, performance queries, and visualization using Power BI.

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

* **Students**: Stores student info (name, email, DOB)
* **Instructors**: Contains instructor info (name, email)
* **Courses**: Course details with a foreign key reference to instructors
* **Enrollments**: Connects students to courses and stores grades and enrollment dates

---

## 🔢 Key Queries

* **Top 3 Students by GPA**
* **Students Enrolled in Courses Taught by 'John Smith'**
* **Students Failing More Than One Course**
* **Average Grade per Course**
* **Students’ Average Grade Across All Courses**

---

## 📈 Sample Output Screenshots

See `dashboard/course_dashboard.pbix` for:

* Overall student performance
* Course average grades
* Instructor course statistics

---

## ⚡ Challenges and Lessons Learned

* Ensuring data relationships were correctly enforced using foreign keys
* Generating realistic sample data with Faker
* Efficient querying on large data using indexes
* Translating raw data into actionable insights through Power BI
* Understanding the value of normalization and schema design

---

## 📜 License

MIT License

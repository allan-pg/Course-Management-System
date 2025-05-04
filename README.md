# 🎓 Course Management System

This project is a relational database-based system for managing students, instructors, courses, and enrollments — built with PostgreSQL, DBeaver, Aiven, and Power BI.

---

## 🔧 Tech Stack

* PostgreSQL (via [Aiven.io](https://aiven.io/))
* DBeaver (DB GUI)
* Python + Faker (for mock data generation)
* Power BI (for dashboarding)

---

## 🗂️ Features

* Manage Students, Instructors, Courses
* Track Enrollments and Grades
* Query-based analytics (e.g., top students, course performance)
* Power BI dashboard with KPIs and charts
* SQL Triggers, Views, Indexes for optimization and logging

---

## 📊 Database Schema

The system includes the following tables:

| Table         | Description                             |
| ------------- | --------------------------------------- |
| `Students`    | Student info (name, email, DOB)         |
| `Instructors` | Instructor info                         |
| `Courses`     | Courses offered with instructor FK      |
| `Enrollments` | Which student is in what course & grade |

See `docs/ERD.png` for full schema diagram.

---

## 📊 Power BI Dashboard

See: `dashboard/course_dashboard.pbix`

* Total Students, Courses, Instructors
* Top Students by GPA
* Courses by Avg Grade
* Student-level performance breakdown

---

## 📦 SQL Highlights

* `sql/schema.sql`: Create all tables with constraints
* `sql/views.sql`: `student_course_summary` view
* `sql/queries.sql`:

  * Top 3 students
  * Failing students
  * Enrollments under “John Smith”
* `sql/triggers.sql`: Log insertions into Enrollments

---

## 🚀 Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/yourusername/course-management-system.git
cd course-management-system
```

### 2. Set Up the Database

Run schema and data:

```sql
-- In DBeaver or pgAdmin
\i sql/schema.sql
\i data/sample_data.sql
```

### 3. Run Queries

Explore:

```sql
\i sql/queries.sql
```

---

## 💡 To-Do

* [ ] Add user interface with Python Flask
* [ ] Export dashboard to web
* [ ] Dockerize the app

---

## 📜 License

MIT License.

# 🎓 Course Management System

## 📓 Project Overview

Course Management System is a database-driven solution that enables tracking of enrollments, grades, and overall course performance. It stores students information, students enrollments courses offered, and instructors for the courses offered and designed to manage the relationships between students, instructors, and courses. It is Built using PostgreSQL on Aiven and managed through DBeaver.

## 🔧 Tech Stack

* PostgreSQL
* aiven cloud based database solution
* DBeaver (DB GUI)
* Python + Faker (for mock data generation)


## 🔍 ERD (Entity Relationship Diagram)

![image](https://github.com/user-attachments/assets/f1eb121a-4945-42d4-a7a4-c09b45fcfab3)


## 📂 Instructions to Run the SQL Code

1. Clone the Repo:

```bash
git clone https://github.com/allan-pg/Course-Management-System.git
cd course-management-system
```

2. Set Up the Database in DBeaver or pgAdmin Manually:

```sql
-- Create databse
create database course_management

-- create tables
\i data/create_tables.sql
```

3. Populate Database with Fake Data Using Python  
Make sure you have installed Python together with psycopg2 and Faker:
```python
pip install psycopg2 faker
```
Run the Python script to populate Students, Instructors, Courses, and Enrollments  
```python
python data/populate_data.ipynb
```
This will generate and insert realistic fake data into your PostgreSQL database  
**NOTE:- I am using Jupyter Notebook for this project and ensure to use your <b>Own Aiven Credentials<b>**

4. Explore Queries:

```sql
\i sql_queries.sql
```


## 📄 Explanation of the Database Schema

**1. Students**:
- Stores student info that is (student_id, name, email, DOB)

**2. Instructors**:
- Contains instructor info (instructor_id, name, email)

**3. Courses**:  
- contains course details(course_name, course_description) with a foreign key referencing to instructors table
  
**4. Enrollments**:  
- Connects students to courses and stores grades and enrollment dates


## 🔢 Key Queries

**1. Top 3 Students by GPA**
```sql
with student_avg as (
	select student_id,
	 	   round(avg(
	 		   		case
	 		   		when grade = 'A' then 4
	 		   		when grade = 'B' then 3
	 		   		when grade = 'C' then 2
	 		   		when grade = 'D' then 1
	 		   		else 0
	 		   end), 2) as course_score
	 	from enrollments
	 	group by student_id)

select s.first_name, s.last_name, sa.course_score
from students s 
join student_avg sa on s.student_id = sa.student_id
order by sa.course_score desc
limit 3;
```
**Output Top 3 Students by GPA**

![image](https://github.com/user-attachments/assets/8ed0a305-4f94-49e8-98d7-c6252a5e910a)

**These are our top 3 students with GPA of 4**  
**2. Students Enrolled in Courses Taught by 'John Smith'**
```sql
select s.student_id, s.first_name, s.last_name
from students s 
join enrollments e on s.student_id = e.student_id
join courses c on c.course_id = e.course_id
join instructors i on i.instructor_id = c.instructor_id
where i.first_name like 'John' and i.last_name like 'Smith';
```
**Output Students Enrolled in Courses Taught by 'John Smith'**  

![image](https://github.com/user-attachments/assets/22f042d3-4f68-4508-801d-09b2765359bb)
  
**Note: There was no instructor by the name 'John Smith' in our Instructors table**  

**3. Students Failing More Than One Course**
```sql
SELECT s.student_id, s.first_name, s.last_name, COUNT(*) AS failed_courses
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.grade = 'F'
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(*) > 1;
```
**Output Students Failing More Than One Course**  
![image](https://github.com/user-attachments/assets/fe4bb5cf-4a4f-4826-b9f1-80c55c73bf6e)  

**Note Jessica Mack has failed more than one course**    

**4. Average Grade per Course**
```sql
 with student_score as (
 	select course_id,
 		   round(avg(
 		   		case
 		   		when grade = 'A' then 4
 		   		when grade = 'B' then 3
 		   		when grade = 'C' then 2
 		   		when grade = 'D' then 1
 		   		else 0
 		   end), 2) as course_score
 	from enrollments
 	group by course_id
 )

 select c.course_name, s.course_score
 from courses c 
 join student_score s on c.course_id = s.course_id
 order by s.course_score desc;
```
**Ouput: Average grade per course**  
![image](https://github.com/user-attachments/assets/a33ee0e1-8536-426c-a3f5-16da6e3f08fa)  

**Transport Plasnner leads with an average of 3.5**  

**5. Students’ Average Grade Across All Courses**
```sql
with student_avg as (
	select student_id,
	 	   round(avg(
	 		   		case
	 		   		when grade = 'A' then 4
	 		   		when grade = 'B' then 3
	 		   		when grade = 'C' then 2
	 		   		when grade = 'D' then 1
	 		   		else 0
	 		   end), 2) as course_score
	 	from enrollments
	 	group by student_id)

select s.first_name, s.last_name, sa.course_score
from students s 
join student_avg sa on s.student_id = sa.student_id
order by sa.course_score desc;
```
**Output:- Students’ Average Grade Across All Courses**  
![image](https://github.com/user-attachments/assets/726c3387-7cbc-4469-b31b-6d800e29e358)  

**Top Student leads with a Average grade of 4**  

**6. Instructors with the number of courses they teach.**
```sql
with instructor_courses as (
	select instructor_id, COUNT(course_id) as no_courses
	from courses
	group by instructor_id)
select concat(i.first_name, ' ', i.last_name) as full_name, ic.no_courses
from instructors i 
join instructor_courses ic on i.instructor_id = ic.instructor_id;
```
**Output:- Instructors with the number of courses they teach.**  
![image](https://github.com/user-attachments/assets/44a8fd47-bdbb-4f6d-b858-ae7b61efc7b0)  

**There are 10 courses and Evelyn Rogers leads in number of courses they teach**

**7. Create a VIEW named student_course_summary (student name, course, grade).**
```SQL
create view student_course_summary as(
	select concat(s.first_name, ' ', s.last_name) as student_name,
		   c.course_name,
		   e.grade
	from students s
	join enrollments e on s.student_id = e.student_id
	join courses c on c.course_id = e.course_id
)
```
** Created a View named student_course_summary that shows students name, course they are enrolled in and their grade**  

**8. Add an INDEX on Enrollments.student_id.**
```sql
create index student_idx
on enrollments(student_id);
```
**Added an index on enrollment table on student_id column for faster retrieval of data from enrollment table**  

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
- Utilize Triggers and logging mechanisms to track real time changes

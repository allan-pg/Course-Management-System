-- Students who enrolled in at least one course.
with cte as (
select s.student_id, count(c.course_id)
from students s 
join enrollments e on s.student_id = e.student_id
join courses c on c.course_id = e.course_id
group by s.student_id
having count(c.course_id) >= 1)

select s.first_name, s.last_name, s.email
from students s 
join cte c on s.student_id = c.student_id;

-- Students enrolled in more than two courses.
with student_enrollment as (
select s.student_id, count(c.course_id)
from students s 
join enrollments e on s.student_id = e.student_id
join courses c on c.course_id = e.course_id
group by s.student_id
having count(c.course_id) > 2)

select s.first_name, s.last_name, s.email
from students s 
join student_enrollment se on s.student_id = se.student_id;

-- Courses with total enrolled students.
with total_enrollment as (
	select c.course_id, count(e.student_id) as total_enrolled
	from courses c 
	join enrollments e on c.course_id = e.course_id
	group by c.course_id)
select c.course_name, t.total_enrolled
from courses c 
join total_enrollment t on c.course_id = t.course_id
order by t.total_enrolled desc;

-- Average grade per course (A=4, ..., F=0).
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
 
 -- - Students who haven’t enrolled in any course.
with not_enrolled as(
	 select s.student_id, e.enrollment_id
	 from students s 
	 left join enrollments e on s.student_id = e.student_id
	 where e.enrollment_id is null)
 
select concat(s.first_name, ' ' , s.last_name) as full_name
from students s 
join not_enrolled n on s.student_id = n.student_id;

-- Students with their average grade across all courses.
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

-- Instructors with the number of courses they teach.
with instructor_courses as (
	select instructor_id, COUNT(course_id) as no_courses
	from courses
	group by instructor_id)
select concat(i.first_name, ' ', i.last_name) as full_name, ic.no_courses
from instructors i 
join instructor_courses ic on i.instructor_id = ic.instructor_id;

-- - Students enrolled in a course taught by “John Smith”.
select s.student_id, s.first_name, s.last_name
from students s 
join enrollments e on s.student_id = e.student_id
join courses c on c.course_id = e.course_id
join instructors i on i.instructor_id = c.instructor_id
where i.first_name like 'John' and i.last_name like 'Smith';

-- Top 3 students by average grade.

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


-- Students failing (grade = ‘F’) in more than one course.
SELECT s.student_id, s.first_name, s.last_name, COUNT(*) AS failed_courses
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.grade = 'F'
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(*) > 1;



-- Create a VIEW named student_course_summary (student name, course, grade).
create view student_course_summary as(
	select concat(s.first_name, ' ', s.last_name) as student_name,
		   c.course_name,
		   e.grade
	from students s
	join enrollments e on s.student_id = e.student_id
	join courses c on c.course_id = e.course_id
)
-- Add an INDEX on Enrollments.student_id.

create index student_idx
on enrollments(student_id);


-- Optional: Create a trigger or stored procedure that logs new enrollments.

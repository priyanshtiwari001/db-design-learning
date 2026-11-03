-- Theme: two upgrades that make junctions production-grade. (1) The relationship often has its own data — grade, status, created_at. (2) Right now nothing stops a student enrolling in DBMS twice. Today the database starts saying "no" for you.


alter table enrollments
add column grade integer,
add column status varchar(20) default 'active',
add constraint uq_student_course
    unique (student_id,course_id);



-- Each student's average grade
select s.name, cast(avg(e.grade) as DECIMAL(5,2)) as avg_grade from enrollments e 
join courses c on e.course_id = c.id 
join students s on e.student_id = s.id group by s.name

-- Grade report for one course
select s.name, c.title ,e.grade from enrollments e 
join courses c on e.course_id = c.id
join students s on e.student_id = s.id
 where c.title = 'SAP' ;

--  the course with the highest average grade
select c.title, cast(avg(e.grade) as Decimal(5,2)) as avg_grade from enrollments e  
join courses c on e.course_id = c.id
group by c.title order by avg_grade desc limit 1;
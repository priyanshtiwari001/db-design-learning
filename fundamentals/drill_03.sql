-- Theme: student takes many courses. Course has many students. Two yeses → M:N. Today you'll prove why no amount of cleverness avoids the third table.

create table students(
    id serial primary key,
    name varchar(200) not null,
    email varchar(100) not null unique
);

create table courses(
    id serial primary key,
    title varchar(200) not null,
    credit integer default 0
)


create table enrollments(
    id serial primary key, 
    student_id integer not null,
    constraint fk_student_id
        foreign key (student_id) 
        references students(id),
    course_id integer not null, 
        foreign key (course_id) 
        references courses(id),
    enrolled_on date default current_date
);


insert into students  (name,email) values
('Prakhar','p@gmail.com'),
('Priyanshu','priyanshu@gmail.com'),
('Vikam','v@gmail.com')


insert into courses (title,credit)
values 
('DBMS',10),
('SAP',7),
('Python',20),
('Excel',DEFAULT);


insert into tcourses (title,credit)
values 
('DBMS',10),
('SAP',2,7),
('Python',1,20),
('Excel',3,DEFAULT);

insert into enrollments (student_id,course_id,grade)
values 
(1,1,40),
(2,2),
(1,3),
(3,1);


-- SELECT QURIES


-- All courses for one student
select c.title,s.name,e.grade,c.id,s.id from enrollments e join students s on  e.student_id = s.id join courses c on e.course_id = c.id 

-- All students in one course
select c.title,s.name,  from enrollments e join students s on  e.student_id = s.id join courses c on e.course_id = c.id where c.title = 'DBMS';

-- Course popularity:
select c.title, count(c.id) as total_courses from enrollments e join students s on  e.student_id = s.id join courses c on e.course_id = c.id group by c.id,c.title;


-- students taking more than one course
select s.name, count(c.id) as total_courses from enrollments e join students s on  e.student_id = s.id join courses c on e.course_id = c.id group by s.name having count(c.id) > 1 ;

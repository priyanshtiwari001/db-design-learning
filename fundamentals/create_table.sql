create table authors (
    id serial primary key  ,
    name varchar(100),
    country varchar(100)
);

create table books (
    id serial primary key  ,
    title varchar(100),
    published_year int,
    author_id integer,
    constraint fk_author
        foreign key (author_id)
        references authors(id)
        on delete cascade
);


create table members(
    id serial primary key,
    name varchar(100),
    email varchar(100) unique,
    joined_date date default (current_date)
);

create table loans(
    id serial primary key,
    book_id int not null,
    member_id int not null,
    loaned_on date default (current_date),
    due_date date null,
    returned_on date null,
    constraint fk_book
        foreign key (book_id)
        references books(id)
        ON DELETE set null,
    constraint fk_member
        foreign key (member_id)
        references members(id)
        ON DELETE RESTRICT  
);


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
-- Members & Loans
-- members: id, name, email (UNIQUE), joined_date (with a DEFAULT of today)
-- loans: id, book_id (FK, NOT NULL), member_id (FK, NOT NULL), loaned_on (DEFAULT today),

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
);

alter table loans 
    add column  loaned_on date default (current_date),
    add column due_date date null,
    add column returned_on date null;


-- Insert in member
INSERT INTO members (name, email)
VALUES
    ('Priyanshu', 'priyanshu@example.com'),
    ('Rahul', 'rahul@example.com'),
    ('Aman', 'aman@example.com');

--  insert loan
INSERT INTO loans (book_id, member_id, due_date)
VALUES
    (4, 1, CURRENT_DATE + 14),
    (2, 2, CURRENT_DATE + 14),
    (3, 1, CURRENT_DATE + 7);


select l.id as loan_id,b.id as book_id,l.returned_on, b.title, m.name, l.due_date from loans l 
join books b on b.id = l.book_id 
join members m on m.id = l.member_id where l.returned_on IS NULL;


delete from books where id = 2;


update  loans set returned_on = CURRENT_DATE where id = 5
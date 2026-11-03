-- Members & Loans
-- members: id, name, email (UNIQUE), joined_date (with a DEFAULT of today)
-- loans: id, book_id (FK, NOT NULL), member_id (FK, NOT NULL), loaned_on (DEFAULT today),


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
    (2, 1, CURRENT_DATE + 14),
     (2, 1, CURRENT_DATE + 2),
      (3, 2, CURRENT_DATE + 10),
       (4, 2, CURRENT_DATE + 4)


select l.id as loan_id,b.id as book_id,l.returned_on, b.title, m.name, l.due_date from loans l 
join books b on b.id = l.book_id 
join members m on m.id = l.member_id where l.returned_on IS NULL;


delete from books where id = 2;


update  loans set returned_on = CURRENT_DATE where id = 5
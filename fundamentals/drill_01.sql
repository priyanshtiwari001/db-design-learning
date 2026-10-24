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
);

insert into authors (name, country)
values
    ('priyanshu', 'india'),
    ('nandini', 'india');

insert into books (title,published_year,author_id)
values ('Harry Potter and the Philosopher’s Stone',1997,1),
    ('The Alchemist',1988,2),
    ('Wings of Fire',1999,1),
    ('The Jungle Book',1988,1);


-- all books with author name (JOIN)
select b.title,b.published_year,au.name from books b inner join authors au on au.id = b.author_id;


-- number of books per author
select au.name, count(b.id) as number_of_book_per_author from authors au join books b on b.author_id = au.id group by au.id, au.name;
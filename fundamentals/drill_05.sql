-- Theme: the FK rules you learned never said "must point at a different table." Today: the table references itself. Two flavors — and the second one is literally Twitter's follower system, your Phase 2 warmup.

create table employees (
    id serial primary key,
    name varchar(200),
    manager_id int ,
    constraint fk_employee
        foreign key (manager_id)
        references employees(id)
        on delete set null
);

insert into employees (name,manager_id) values 
('Priyanshu Tiwari',NULL),
('ram singh',1),
('pratap singh',1);


INSERT INTO employees (name, manager_id)
VALUES
    ('Employee 1', 2),
    ('Employee 2', 2),
    ('Employee 3', 3),
    ('Employee 4', 3);


-- each employee with manager name
select m.name as manager_name,e.name as employee_name from employees e left join employees m   on e.manager_id = m.id ;


-- direct reports per manager
select count(e.id) as emplyee_count, m.name from employees e inner join employees m on e.manager_id = m.id group by m.name;



alter table employees 
add constraint chk_employee_not_own_manager check (id <>  manager_id)

ALTER TABLE employees
ADD CONSTRAINT chk_employee_not_own_manager
CHECK (id <> manager_id);


-- Who is my manager's manager?
select  distinct m.name as manager_name, gm.name as group_manager from employees e left join  employees m on e.manager_id = m.id left join employees gm on m.manager_id = gm.id;

-- Employees whose manager reports to the CEO
select   distinct m.name as manager_name, gm.name as group_manager from employees e left join  employees m on e.manager_id = m.id left join employees gm on m.manager_id = gm.id where gm.manager_id is null;


-- Who is a manager?
select distinct m.name as manager_name from employees e inner join employees m on e.manager_id = m.id;


-- Co-worker pairs — two employees sharing a manager
    select distinct  e1.name as employee_name from employees e1 join employees e2 on e1.manager_id = e2.manager_id where e1.id < e2.id order by employee_name;
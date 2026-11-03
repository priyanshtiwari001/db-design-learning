# Basic commands sql [Commands](https://www.dbvis.com/wp-content/uploads/2024/04/SQL-Cheat-Sheet.pdf)

- docker exec -it db-design-pratice psql -U  postgres -d  sql_practice
psql 

#### DRILL 01
 - Group by
 - Joins 

#### DRILL 02 (Constraints & Delete Behavior)

Constraints 
    - SQL Constraints are rules applied to columns in a table to restrict the type of data that can be stored.
    - help maintain data accuracy, consistency and integrity in a database
    - commonly used SQL Constraints are:
        NOT NULL - a column cannot contain NULL values. Used when we require in every row.

        UNIQUE - ensures that all values in a column are different. prevent the duplication of records.

        PRIMARY KEY - constraint uniquely identifies each row in a table. A primary key cannot contain NULL or duplicate values.

        FOREIGN KEY - used to establish a relationship between two tables. It ensures that the value in one table refers to a valid value in another table.

        CHECK - constraint ensures that the values in a column satisfy a specified condition.
        
        DEFAULT - constraint automatically assigns a specified value to a column when no value is provided.



Q1: One sentence each: what do RESTRICT, CASCADE, SET NULL do? Which would you pick for loans → member and why?


ON DELETE RESTRICT:
 	- Prevents deletion of a parent row if any child rows reference it through a foreign key. 
    - The dependent records must be handled before the parent can be deleted.	
    - A member cannot be deleted while loan records reference that member.
ON DELETE CASCADE	
    - Automatically deletes the dependent child rows when the referenced parent row is deleted, maintaining referential integrity without requiring separate delete queries.	
    - Deleting a member automatically deletes all their associated loans.
ON DELETE SET NULL	
    - Allows the parent row to be deleted while preserving the child rows, but sets their       foreign key column to NULL. 
    - The foreign key column must permit NULL values.	
    - Deleting a member preserves their loan records but sets loans.member_id to NULL.



### DRILL 03:

Why do we need a junction table?

    1. To handle many-to-many relationships: One student can enroll in many courses, and one course can have many students.

    2. To avoid duplicate data: Without a junction table, you may create a new DBMS row every time another student enrolls in DBMS.

    3. To avoid update anomalies: If DBMS credits change from 10 to 100, duplicated records require multiple updates. Missing one can cause inconsistent data.

    4. To avoid insertion anomalies: You should be able to create a course before any student enrolls in it. If student_id is mandatory in courses, you cannot insert a course without a student.

    5. To avoid deletion anomalies: If you delete the last student's DBMS row, you might accidentally delete the only record containing DBMS course information.

    6. To maintain data integrity: Foreign keys ensure that an enrollment references an existing student and an existing course.

    7. To store relationship-specific information: You can store enrolled_on, grade, status, or semester in the junction table because these details belong to the enrollment, not the course itself.


### DRILL 5 Self-Reference (a table pointing at itself)

Flavor 1 — self 1:N: one manager manages many employees; each employee has ONE manager. Same FK rule as Day 1 — the "one" side holds the reference — so employees.manager_id → employees.id. One table, two roles: each row is both an employee and somebody's manager.

Flavor 2 — self M:N: user follows many users, is followed by many users. Two yeses → junction. So: follows(follower_id, following_id) — two FKs to the same table, each meaning something different. follower_id = who clicks follow, following_id = who gets followed. Naming the roles correctly is the design work here.

 - Three self-reference specials:

    manager_id must be nullable — the CEO has no manager (NULL = "top of tree," same NULL-as-state idea as returned_on)
    CHECK constraint (new tool) — check (manager_id <> id): nobody manages themselves. CHECK = any business rule the engine enforces
    ON DELETE for manager: SET NULL — manager leaves, employees stay (and it works precisely because the column is nullable. 
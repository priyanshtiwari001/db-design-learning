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




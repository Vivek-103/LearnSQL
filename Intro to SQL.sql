CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(20),
    major VARCHAR(20)
);

DESCRIBE student;

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3,2);

ALTER TABLE student DROP COLUMN gpa;

INSERT INTO student(student_id,name) VALUES(4,'Claire');

DELETE FROM student
where student_id = 4;

INSERT INTO student VALUES(4,'Jack','Biology');

INSERT INTO student VALUES(5,'Mike','Computer Science');

SELECT * FROM student;

UPDATE student
SET major = 'Comp Sci'
WHERE major = 'Computer Science';

SELECT name from student;

SELECT student.name , student.major from student
ORDER BY name;

SELECT * from student
ORDER BY student_id DESC;

SELECT * FROM student
WHERE major = 'Bio';

-- other operators {<,>,<=,>=,<>,AND,OR}

SELECT * FROM student
WHERE student_id <= 3 AND name <> 'Jack';

SELECT * FROM student
WHERE name IN('Claire','Kate','Mike');

SHOW DATABASES;

CREATE DATABASE Company;

USE company;


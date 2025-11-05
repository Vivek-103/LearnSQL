
-- Basic SQL Queries
1. Find all employees who have a salary greater than 70,000 and were born after 1970.
SELECT * 
FROM employee
WHERE salary > 70000 AND birth_day > '1970-01-01';

2. Find the highest salary of each branch.
SELECT branch.branch_name, MAX(employee.salary) AS highest_salary
FROM branch
JOIN employee ON branch.branch_id = employee.branch_id
GROUP BY branch.branch_name;

3. Find all employees who have no supervisor (i.e., super_id is NULL).
SELECT * 
FROM employee
WHERE super_id IS NULL;

4. Find the employees who have the same supervisor.
SELECT super_id, COUNT(emp_id) AS num_employees
FROM employee
GROUP BY super_id
HAVING COUNT(emp_id) > 1;

-- Aggregate Functions and Grouping
5. Find the average sales made by each employee.
SELECT emp_id, AVG(total_sales) AS avg_sales
FROM works_with
GROUP BY emp_id;

6. Find the total salary expenditure for each branch.
SELECT branch.branch_name, SUM(employee.salary) AS total_salary
FROM branch
JOIN employee ON branch.branch_id = employee.branch_id
GROUP BY branch.branch_name;

7. Find the employee who made the highest sales for each client.
SELECT client.client_name, employee.first_name, employee.last_name, MAX(works_with.total_sales) AS highest_sales
FROM works_with
JOIN client ON works_with.client_id = client.client_id
JOIN employee ON works_with.emp_id = employee.emp_id
GROUP BY client.client_name;

-- Advanced SQL Queries
8. Find the second highest salary in the company.
SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);

9. Find the branches that have more than one supplier.
SELECT branch.branch_name
FROM branch_supplier
JOIN branch ON branch_supplier.branch_id = branch.branch_id
GROUP BY branch.branch_name
HAVING COUNT(supplier_name) > 1;

10. Find all clients who have made sales over 100,000.
SELECT client.client_name, SUM(works_with.total_sales) AS total_sales
FROM works_with
JOIN client ON works_with.client_id = client.client_id
GROUP BY client.client_name
HAVING SUM(works_with.total_sales) > 100000;

-- Subqueries and Joins
11. Find all employees who have sold to a client named 'FedEx'.
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT emp_id
    FROM works_with
    WHERE client_id = (SELECT client_id FROM client WHERE client_name = 'FedEx')
);

12. Find the branch that has the highest total sales.
SELECT branch.branch_name
FROM branch
JOIN works_with ON branch.branch_id = works_with.branch_id
GROUP BY branch.branch_name
ORDER BY SUM(works_with.total_sales) DESC
LIMIT 1;

13. Find all clients who have not been served by any employee yet.
SELECT client.client_name
FROM client
WHERE client.client_id NOT IN (
    SELECT client_id
    FROM works_with
);

-- String Manipulation and Pattern Matching
14. Find all employees whose last name starts with 'S'.
SELECT * 
FROM employee
WHERE last_name LIKE 'S%';

15. Find the total number of clients whose name contains 'Inc'.
SELECT COUNT(*)
FROM client
WHERE client_name LIKE '%Inc%';

-- Data Modification and Updates
16. Increase the salary of all employees in the 'Scranton' branch by 10%.
UPDATE employee
SET salary = salary * 1.10
WHERE branch_id = (SELECT branch_id FROM branch WHERE branch_name = 'Scranton');

17. Delete all employees who have a salary below 50,000.
DELETE FROM employee
WHERE salary < 50000;

18. Change the branch name of branch with branch_id = 3 to 'New Stamford'.
UPDATE branch
SET branch_name = 'New Stamford'
WHERE branch_id = 3;

-- Complex Joins and Data Aggregation
19. Find all employees who work with clients from multiple branches.
SELECT employee.first_name, employee.last_name
FROM employee
JOIN works_with ON employee.emp_id = works_with.emp_id
JOIN client ON works_with.client_id = client.client_id
GROUP BY employee.emp_id
HAVING COUNT(DISTINCT client.branch_id) > 1;

20. Find the total number of clients served by each branch manager.
SELECT employee.first_name, employee.last_name, COUNT(DISTINCT client.client_id) AS total_clients
FROM employee
JOIN branch ON employee.emp_id = branch.mgr_id
JOIN client ON branch.branch_id = client.branch_id
GROUP BY employee.emp_id;

-- Bonus Questions
21. Find the branch with the least number of clients.
SELECT branch.branch_name
FROM branch
LEFT JOIN client ON branch.branch_id = client.branch_id
GROUP BY branch.branch_name
ORDER BY COUNT(client.client_id) ASC
LIMIT 1;

22. Find the number of clients for each supplier.
SELECT branch_supplier.supplier_name, COUNT(DISTINCT client.client_id) AS num_clients
FROM branch_supplier
LEFT JOIN client ON branch_supplier.branch_id = client.branch_id
GROUP BY branch_supplier.supplier_name;

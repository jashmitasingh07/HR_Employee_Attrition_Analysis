-- CREATE DATABASE hr_employee;
 
USE hr_employee;

SELECT * FROM hr_employee_attrition;

-- 1. calculate total employee 
-- SELECT COUNT(EmployeeNumber) AS totalEmpNo FROM hr_employee_attrition;

-- 2. How many employees left the company
-- SELECT COUNT(EmployeeNumber) AS Total_employee FROM hr_employee_attrition
-- WHERE Attrition = 'Yes';

-- 3. calculate the percentage of employees who left the company out of the total employees. 
-- SELECT ROUND(
-- 		COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0
--         /COUNT(EmployeeNumber),2) AS Attrition_rate
-- FROM hr_employee_attrition;

-- 4. what percentage of employees work overtime out of the total employees;
-- SELECT ROUND(
-- 	COUNT(CASE WHEN OverTime = 'Yes' THEN 1 END) * 100.0
--     / COUNT(EmployeeNumber) , 2) AS Overtime_rate
-- FROM hr_employee_attrition;

-- 5. Find the total number of employees who left the company in each department
-- SELECT Department, COUNT(EmployeeNumber) AS total_employee
-- FROM hr_employee_attrition
-- WHERE Attrition = 'Yes'
-- GROUP BY Department;

-- 6. Find the average monthly income for each dept and display the departments from highest to lowest average income
-- SELECT Department, AVG(MonthlyIncome) AS avg_monthly_income
-- FROM hr_employee_attrition
-- GROUP BY Department
-- ORDER BY avg_monthly_income DESC;

-- 7. Find the job role wuth the highest number of employees who left the company
-- SELECT JobRole, COUNT(EmployeeNumber) AS attrition_of_jobrole
-- FROM hr_employee_attrition
-- WHERE Attrition = 'Yes'
-- GROUP BY JobRole
-- ORDER BY attrition_of_jobrole DESC LIMIT 1;

-- 8. Find the avg monthly income of employees who left the company and emps who stayed in the companny.
-- SELECT Attrition, COUNT(EmployeeNumber) AS Totalemp, AVG(MonthlyIncome) AS avg_income
-- FROM hr_employee_attrition
-- GROUP BY Attrition ;

-- 9. Find the attrition rate for each dept
-- SELECT Department, ROUND
-- 	(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END )*100.0
--     / COUNT(EmployeeNumber),2) AS Attrition_rate
-- FROM hr_employee_attrition
-- GROUP BY Department;

-- 10.Find the top 3 job roles with the highest avg monthly income
-- SELECT JobRole, AVG(MonthlyIncome) AS avg_income
-- FROM hr_employee_attrition
-- GROUP BY JobRole
-- ORDER BY avg_income DESC LIMIT 3;

-- 11. Find the avg job satisfaction for emps who work overtime and emps who dont work overtime
-- SELECT OverTime, ROUND(AVG(JobSatisfaction),2) AS avg_satisfaction
-- FROM hr_employee_attrition
-- GROUP BY OverTime;

-- 12. Find the number of emps in each job role who have jobsatisfaction less than 3.
-- SELECT JobRole, COUNT(EmployeeNumber) AS TotalEmp, JobSatisfaction
-- FROM hr_employee_attrition
-- WHERE JobSatisfaction < 3
-- GROUP BY JobRole, JobSatisfaction;

-- 13. Find the department with the highest number of employees working overtime.
-- SELECT Department, COUNT(EmployeeNumber) AS TotalEmp
-- FROM hr_employee_attrition
-- WHERE OverTime = 'Yes'
-- GROUP BY Department
-- ORDER BY TotalEmp DESC LIMIT 1;

-- 14. Find the average monthly income for each Job Role, but show only those Job Roles where the average monthly income is greater than 5,000.
-- SELECT JobRole, AVG(MonthlyIncome) AS avg_income
-- FROM hr_employee_attrition
-- GROUP BY JobRole
-- HAVING avg_income > 5000;

-- 15. Find the attrition rate for employees who work overtime and employees who do not work overtime.
-- SELECT OverTime, ROUND
-- 	(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 
--     / COUNT(EmployeeNumber), 2) AS Attrition_rate
-- FROM hr_employee_attrition
-- GROUP BY OverTime;

-- 16. Find employees whose Monthly Income is greater than the average Monthly Income of all employees.
-- SELECT EmployeeNumber FROM hr_employee_attrition
-- WHERE MonthlyIncome > (SELECT AVG(MonthlyIncome) FROM hr_employee_attrition);

-- 17. Find the employees who have more years at the company than the average YearsAtCompany of all employees.
-- SELECT EmployeeNumber FROM hr_employee_attrition
-- WHERE YearsAtCompany > (SELECT AVG(YearsAtCompany) From hr_employee_attrition);

-- 18. Find the Job Roles whose average Monthly Income is greater than the overall average Monthly Income of all employees.
-- SELECT JobRole, AVG(MonthlyIncome) AS avg_income
-- FROM hr_employee_attrition
-- GROUP BY JobRole
-- HAVING AVG(MonthlyIncome) > (SELECT AVG(MonthlyIncome) FROM hr_employee_attrition);

-- 19. Find the Departments whose average JobSatisfaction is greater than the overall average JobSatisfaction of all employees.
-- SELECT Department, AVG(JobSatisfaction) AS avg_jobsatisfaction
-- FROM hr_employee_attrition
-- GROUP BY Department
-- HAVING AVG(JobSatisfaction) > (SELECT AVG(JobSatisfaction) FROM hr_employee_attrition);

-- 20. Rank all Job Roles based on their average Monthly Income, from highest to lowest.
-- SELECT JobRole, AVG(MonthlyIncome) AS avg_income,
-- RANK() OVER (ORDER BY AVG(MonthlyIncome) DESC) AS rank_job 
-- FROM hr_employee_attrition
-- GROUP BY JobRole;

-- 21. Assign a row number to employees within each Department based on their Monthly Income, with the highest-paid employee receiving row number 1.
-- SELECT EmployeeNumber, Department,
-- ROW_NUMBER() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS rownumber
-- FROM hr_employee_attrition;

-- 22. Find the top 3 highest-paid employees from each Department.
-- WITH emp AS (
-- 	SELECT EmployeeNumber, Department, MonthlyIncome,
--     ROW_NUMBER() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS rownumber
--     FROM hr_employee_attrition
-- )
-- SELECT EmployeeNumber, Department, MonthlyIncome, rownumber
-- FROM emp
-- WHERE rownumber <= 3;

-- 23. Rank employees within each Job Role based on Monthly Income using DENSE_RANK(), with the highest-paid employee receiving rank 1.
-- SELECT EmployeeNumber, MonthlyIncome, JobRole, 
-- DENSE_RANK() OVER (PARTITION BY JobRole ORDER BY MonthlyIncome DESC) AS denserank
-- FROM hr_employee_attrition;

-- 24. Find the top 2 highest-paid employees from each Job Role using DENSE_RANK().
-- WITH emp AS (
-- 	SELECT EmployeeNumber, JobRole, MonthlyIncome,
--     DENSE_RANK() OVER (PARTITION BY JobRole ORDER BY MonthlyIncome DESC) AS denserank
--     FROM hr_employee_attrition
-- )
-- SELECT EmployeeNumber, JobRole, MonthlyIncome, denserank
-- FROM emp
-- WHERE denserank < 3;

-- 25. Categorize employees based on Monthly Income: Less than 5,000 → Low Income and 5,000 to 10,000 → Medium Income and Above 10,000 → High Income Then find the number of employees in each income category.
-- first way to do
-- WITH CatEmp AS (
-- SELECT COUNT(EmployeeNumber) AS TotalEmp,
-- 		(CASE
-- 			WHEN MonthlyIncome < 5000 THEN 'Low Income'
-- 			WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN 'Medium Income'
-- 			ELSE 'High Income'
--         END) AS categ_emp
-- 	FROM hr_employee_attrition
--     GROUP BY categ_emp
-- )
-- SELECT categ_emp, TotalEmp
-- FROM CatEmp;

-- second way to do
 
-- SELECT COUNT(EmployeeNumber) AS totalemp, (CASE
-- 		WHEN MonthlyIncome < 5000 THEN 'Low Income'
--         WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN 'Medium Income'
--         ELSE 'High Income'
--         END) AS categ_emp
-- FROM hr_employee_attrition
-- GROUP BY categ_emp;

-- 26. For each Department, show the total number of employees and the number of employees who left the company.
-- SELECT Department, COUNT(EmployeeNumber) as TotalEmp,
-- COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS LeftEmp
-- FROM hr_employee_attrition
-- GROUP BY Department;

-- 27. For each Department, show the total number of employees, employees who left, and employees who stayed.
-- SELECT Department, COUNT(EmployeeNumber) as TotalEmp,
-- COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS LeftEmp,
-- COUNT(CASE WHEN Attrition = 'No' THEN 1 END) AS StayedEmp
-- FROM hr_employee_attrition
-- GROUP BY Department;

-- 28. Find the attrition rate for each Job Role and show only those Job Roles where the attrition rate is greater than the overall company attrition rate.
-- SELECT JobRole, ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0
-- 		/ COUNT(EmployeeNumber),2) AS attrition_rate
-- FROM hr_employee_attrition
-- GROUP BY JobRole 
-- HAVING attrition_rate > (SELECT 
-- 							(ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) *100.0
-- 							/ COUNT(EmployeeNumber),2) )
-- FROM hr_employee_attrition);

-- 29. Find all unique Education Fields available in the dataset.
-- first way to do 
-- SELECT EducationField FROM hr_employee_attrition
-- GROUP BY EducationField;

-- 2nd way to do
-- SELECT DISTINCT EducationField FROM hr_employee_attrition;

-- 30. Find all employees who work in either the Sales or Human Resources department.
-- SELECT EmployeeNumber, Department
-- FROM hr_employee_attrition
-- WHERE Department IN ('Sales', 'Human Resources');

-- 31. Find employees whose Monthly Income is between 5,000 and 10,000.
-- SELECT EmployeeNumber, MonthlyIncome
-- FROM hr_employee_attrition
-- WHERE MonthlyIncome BETWEEN 5000 AND 10000;

-- 32. Find all employees whose Job Role contains the word Manager
-- SELECT EmployeeNumber, JobRole FROM hr_employee_attrition
-- WHERE JobRole LIKE '%Manager%';

-- 33. Find employees who work in the Sales department, have OverTime = 'Yes', and have NOT left the company.
-- SELECT EmployeeNumber FROM hr_employee_attrition
-- WHERE Department = 'Sales' AND OverTime = 'Yes' AND Attrition = 'No';

-- 34. Find employees who belong to Sales OR Human Resources department, but do NOT work overtime.
-- SELECT EmployeeNumber , Department FROM hr_employee_attrition
-- WHERE Department IN ('Sales', 'Human Resources') AND NOT OverTime = 'Yes';

-- 35. Find the minimum and maximum Monthly Income for each Department.
-- SELECT Department, MIN(MonthlyIncome) AS Mini, MAX(MonthlyIncome) AS Maxi
-- FROM hr_employee_attrition
-- GROUP BY Department;

-- 36. Display each employee's Job Role in uppercase using the UPPER() function.
-- SELECT EmployeeNumber, UPPER(JobRole) FROM hr_employee_attrition;

-- 37. Display each employee's Job Role and the number of characters in their Job Role.
-- SELECT EmployeeNumber, JobRole, LENGTH(JobRole) AS length FROM hr_employee_attrition;

-- 38. Create a new display value combining EmployeeNumber and JobRole in this format: 101 - Sales Executive.
-- SELECT EmployeeNumber, JobRole, CONCAT(EmployeeNumber, '-' , JobRole) FROM hr_employee_attrition;
 
-- 39. Display EmployeeNumber and JobRole. If JobRole is NULL, display Not Assigned instead.
-- SELECT EmployeeNumber, COALESCE(JobRole, 'NotAssigned') AS JobRole
-- FROM hr_employee_attrition;

-- 40. Display EmployeeNumber and Department. If Department is NULL, display Unknown Department instead.
-- SELECT EmployeeNumber, COALESCE(Department, 'Unkmown Department') AS Department
-- FROM hr_employee_attrition;

-- 41. Display EmployeeNumber, JobSatisfaction, and use NULLIF() to return NULL whenever JobSatisfaction is equal to 1. Otherwise, show the original JobSatisfaction value.
-- SELECT EmployeeNumber, JobSatisfaction, NULLIF(JobSatisfaction, 1) AS Updated
-- FROM hr_employee_attrition;

-- 42. CREATE TABLE + Primary/Foreign Key, phir JOINs.
-- CREATE TABLE department_details(
-- 	DepartmentID INTEGER PRIMARY KEY,
--     Department TEXT NOT NULL,
--     DepartmentHead TEXT,
--     Location TEXT
-- );
-- INSERT INTO department_details (DepartmentID, Department, DepartmentHead, Location) VALUES
-- 	(1, 'Sales', 'Riya Sharma', 'Delhi'),
--     (2, 'Research & Development', 'Aman Verma', 'Noida'),
--     (3, 'Human Resources', 'Neha Singh', 'Gurugram');

SELECT * FROM department_details;

-- 43. Display each employee’s EmployeeNumber, Department, DepartmentHead, and Location by joining hr_employee_attrition with department_details. Use an INNER JOIN.
-- SELECT h.EmployeeNumber, h.Department, d.DepartmentHead, d.Location
-- FROM hr_employee_attrition AS h
-- INNER JOIN department_details AS d
-- ON h.Department = d.Department;

-- 44. Using an INNER JOIN, display EmployeeNumber, JobRole, Department, and DepartmentHead only for employees whose Department is Sales.
-- SELECT H.EmployeeNumber, H.JobRole, H.Department, D.DepartmentHead
-- FROM hr_employee_attrition AS H
-- INNER JOIN department_details AS D
-- ON H.Department = D.Department
-- WHERE H.Department = 'Sales';

-- 45. Display all departments from department_details along with their employees' EmployeeNumber. Use a LEFT JOIN so that a department should still appear even if it has no matching employee
-- SELECT H.EmployeeNumber, D.Department
-- FROM hr_employee_attrition AS H
-- LEFT JOIN department_details AS D
-- ON H.Department = D.Department ;

-- 46. Display ALL employees (EmployeeNumber and Department) along with their DepartmentHead. Even if an employee's department has no matching record in department_details, that employee should still appear.
-- SELECT H.EmployeeNumber, D.Department
-- FROM hr_employee_attrition AS H
-- LEFT JOIN department_details AS D
-- ON H.Department = D.Department;

-- 47. Display all departments with their DepartmentHead and the number of employees in each department. Departments with no employees should also appear.
-- SELECT D.Department, D.DepartmentHead, COUNT(H.EmployeeNumber) AS TotalEmp
-- FROM department_details AS D 
-- LEFT JOIN hr_employee_attrition AS H
-- ON D.Department = H.Department
-- GROUP BY D.Department, D.DepartmentHead;

-- 48. Display ALL employees with their EmployeeNumber, JobRole, Department, and Location. Employees should still appear even if their department has no matching location in department_details.
-- SELECT H.EmployeeNumber, H.JobRole, H.Department, D.Location
-- FROM hr_employee_attritioN AS H
-- LEFT JOIN department_details AS D
-- ON H.Department = D.Department ;

-- 49. Display ALL departments with their DepartmentHead and matching employees' EmployeeNumber, using a RIGHT JOIN.
-- SELECT D.Department, D.DepartmentHead, H.EmployeeNumber
-- FROM hr_employee_attrition AS H 
-- RIGHT JOIN department_details AS D
-- ON H.Department = D.Department;

-- 50. Find departments that have NO matching employees.
-- SELECT D.Department, H.EmployeeNumber
-- FROM department_details AS D
-- LEFT JOIN hr_employee_attrition AS H
-- ON D.Department = H.Department
-- WHERE H.Department IS NULL;

-- 51. Find employees whose department does NOT have a matching record in department_details.
-- SELECT H.EmployeeNumber, H.Department
-- FROM hr_employee_attrition AS H
-- LEFT JOIN department_details AS D
-- ON H.Department = D.Department
-- WHERE D.Department IS NULL;

-- 52. Find pairs of different employees who work in the same Department. Display both EmployeeNumbers and their Department.
-- SELECT A.EmployeeNumber AS Emp1, B.EmployeeNumber AS Emp2, A.Department
-- FROM hr_employee_attrition AS A
-- INNER JOIN hr_employee_attrition AS B
-- ON A.Department = B.Department AND A.EmployeeNumber <> B.EmployeeNumber;

-- 53. Find pairs of different employees who have the same JobRole. Display both EmployeeNumbers and the JobRole.
-- SELECT A.EmployeeNumber AS Emp1, B.EmployeeNumber AS Emp2, A.JobRole
-- FROM hr_employee_attrition AS A
-- INNER JOIN hr_employee_attrition AS B 
-- ON A.JobRole = B.JobRole AND A.EmployeeNumber < B.EmployeeNumber;

-- 54. Create every possible combination of Department from department_details and JobRole from the employee data. Show only unique JobRoles before making the combinations.
-- SELECT DISTINCT D.Department, H.JobRole
-- FROM department_details AS D
-- CROSS JOIN hr_employee_attrition AS H;

-- 55. Display EmployeeNumber, Department, DepartmentHead, and Location by joining hr_employee_attrition and department_details using USING instead of ON.
-- SELECT H.EmployeeNumber, H.Department, D.DepartmentHead, D.Location
-- FROM hr_employee_attrition AS H
-- INNER JOIN department_details AS D
-- USING(Department);

-- 56. Find employees whose JobRole belongs to any JobRole where the average Monthly Income is greater than 8,000.
-- SELECT EmployeeNumber, JobRole, MonthlyIncome FROM hr_employee_attrition
-- WHERE JobRole IN 
-- 	(SELECT JobRole FROM hr_employee_attrition GROUP BY JobRole 
-- 	HAVING AVG(MonthlyIncome)> 8000);

-- 57. Find employees whose Monthly Income is greater than the average Monthly Income of their own Department.
-- SELECT H.EmployeeNumber, H.MonthlyIncome, H.Department 
-- FROM hr_employee_attrition AS H
-- WHERE H.MonthlyIncome  > (
-- 	SELECT AVG(H2.MonthlyIncome)
--     FROM hr_employee_attrition AS H2 
--     WHERE H2.Department = H.Department);

-- 58. Find employees whose YearsAtCompany is greater than the average YearsAtCompany of employees in their own JobRole.
-- SELECT H.EmployeeNumber, H.YearsAtCompany, H.JobRole 
-- FROM hr_employee_attrition AS H
-- WHERE H.YearsAtCompany > (
-- 		SELECT AVG(H2.YearsAtCompany)
--         FROM hr_employee_attrition AS H2
--         WHERE H.JobRole = H2.JobRole
-- );

-- 59. First calculate the average Monthly Income for each Department in a subquery, then display only the Departments whose average income is greater than 6,000.
-- SELECT Department, avg_income
-- FROM (
-- 	SELECT Department, AVG(MonthlyIncome) AS avg_income
-- 	FROM hr_employee_attrition
-- 	GROUP BY Department
-- ) AS dept_avg
-- WHERE avg_income > 6000;

-- 60. Calculate the average JobSatisfaction for each JobRole in a subquery, then display only those Job Roles whose average Job Satisfaction is greater than 2.5.
-- SELECT JobRole, avg_jobsatis
-- FROM(
-- 	SELECT JobRole, AVG(JobSatisfaction) AS avg_jobsatis 
-- 	FROM hr_employee_attrition
-- 	GROUP BY JobRole
-- ) AS avg_jobrole
-- WHERE avg_jobsatis > 2.5;

-- 61. Create one list of Department values from hr_employee_attrition and department_details, with duplicates removed, using UNION.
-- SELECT Department FROM hr_employee_attrition
-- UNION
-- SELECT Department FROM department_details;

-- SELECT Department FROM hr_employee_attrition
-- UNION ALL
-- SELECT Department FROM department_details;

-- 62. Display JobRole after removing extra spaces, convert it to lowercase, and also display the first 5 characters of the JobRole.
-- SELECT TRIM(JobRole), LOWER(JobRole), SUBSTR(JobRole,1,5)
-- FROM hr_employee_attrition;

-- 63. Display MonthlyIncome along with its CEIL(), FLOOR(), and ABS() values.
-- SELECT CEIL(MonthlyIncome), FLOOR(MonthlyIncome), ABS(MonthlyIncome)
-- FROM hr_employee_attrition;

-- 64. Display EmployeeNumber, MonthlyIncome, previous employee's MonthlyIncome, and next employee's MonthlyIncome, when employees are ordered by EmployeeNumber.
-- SELECT EmployeeNumber, MonthlyIncome,
-- LAG(MonthlyIncome) OVER (ORDER BY EmployeeNumber) AS previous,
-- LEAD(MonthlyIncome) OVER (ORDER BY EmployeeNumber) AS nxt
-- FROM hr_employee_attrition;

-- 65. Divide employees into 4 salary groups based on MonthlyIncome, with the highest-paid employees in the first group.
-- SELECT EmployeeNumber, MonthlyIncome,
-- NTILE(4) OVER (ORDER BY MonthlyIncome DESC) AS salarygroup
-- FROM hr_employee_attrition;

-- 66. Create a view named attrition_employees containing EmployeeNumber, Department, JobRole, and MonthlyIncome for only employees who left the company.
-- CREATE VIEW attrition_employee AS
-- SELECT EmployeeNumber, Department, JobRole, MonthlyIncome
-- FROM hr_employee_attrition
-- WHERE Attrition = 'Yes';

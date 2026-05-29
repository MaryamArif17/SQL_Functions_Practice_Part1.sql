/* ----
   DATABASE SETUP
 ------  */

CREATE DATABASE FunctionPractice;
USE FunctionPractice;

/* -----
   TABLE: EMPLOYEE
 -------  */

CREATE TABLE Employee (
EmpID INT PRIMARY KEY,
EmpName VARCHAR(20),
Salary INT,
Department VARCHAR(20)
);

/* ---------
   INSERTING SAMPLE DATA INTO EMPLOYEE TABLE
   --------- */

INSERT INTO Employee VALUES
(1, 'Ali', 50000, 'HR'),
(2, 'Sara', 65000, 'IT'),
(3, 'Usman', 70000, 'Finance'),
(4, 'Ayesha', 55000, 'IT');

/* -------
   BASIC SCALAR FUNCTIONS
 ---------   */

/* ---ADDING FIXED BONUS OF 5000 TO EMPLOYEE SALARY */

CREATE FUNCTION AddBonus ( @Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary + 5000
END;

-- TESTING FUNCTION
SELECT dbo.AddBonus(3000) AS UpdatedSalary;

/* SHOWING EMPLOYEE SALARY AFTER APPLYING BONUS */

SELECT Employee.EmpName, Employee.Salary, dbo.AddBonus(Salary) AS UpdatedSalary 
FROM Employee;

/* DEDUCTING FIXED AMOUNT FROM SALARY */

CREATE FUNCTION DeductSalary(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary - 10000
END;

-- TESTING FUNCTION
SELECT Employee.EmpName, Employee.Salary, dbo.DeductSalary(Salary)
AS UpdatedSalary
FROM Employee;

/* INCREASING SALARY BY 10 PERCENT */

CREATE FUNCTION IncreaseSalary(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary + (@Salary * 10/100)
END;

-- TESTING FUNCTION
SELECT Employee.EmpName, Employee.Salary, dbo.IncreaseSalary(Salary)
AS UpdatedSalary
FROM Employee;

/* CALCULATING ANNUAL SALARY */

CREATE FUNCTION CalculateAnnual(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary * 12
END;

-- TESTING FUNCTION
SELECT Employee.EmpName,
 Employee.Salary, 
 dbo.CalculateAnnual(Salary)
AS AnnualSalary
FROM Employee;

/* DEDUCTING 5 PERCENT TAX FROM SALARY */

CREATE FUNCTION DeductTAX(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary -(@Salary * 5/100)
END;

-- TESTING FUNCTION
SELECT Employee.EmpName,
       Employee.Salary,
       dbo.DeductTAX(Salary) AS UpdatedSalary
FROM Employee;

/* ----------
   CONDITIONAL (CASE-BASED) FUNCTIONS
   ---------- */

/* CLASSIFYING SALARY INTO HIGH OR LOW CATEGORY */

CREATE FUNCTION SalaryCategory(@Salary INT)
RETURNS VARCHAR(20)
AS
BEGIN
RETURN 
CASE 
    WHEN @Salary >60000 THEN 'HIGH SALARY'
    ELSE 'LOW SALARY'
END
END;

-- TESTING FUNCTION
SELECT Employee.EmpName,
       Employee.Salary,
       dbo.SalaryCategory(Salary) AS SalaryCategory
FROM Employee;

/* BONUS CATEGORY BASED ON SALARY RANGE */

CREATE FUNCTION BonusCategory(@Salary INT)
RETURNS VARCHAR(50)
AS
BEGIN
RETURN
CASE
   WHEN @Salary > 65000 THEN 'Elite Bonus'
   WHEN @Salary BETWEEN 50000 AND 65000 THEN 'Standard Bonus'
   ELSE 'Low Bonus'
END
END;

-- TESTING FUNCTION
SELECT Employee.EmpName,
       Employee.Salary,
       dbo.BonusCategory(Salary) AS BonusCategory
FROM Employee;

/* NET SALARY CATEGORY AFTER TAX CALCULATION */

CREATE FUNCTION NetSalaryCategory(@Salary INT)
RETURNS VARCHAR(50)
AS
BEGIN
RETURN
CASE 
    WHEN 
    (@Salary -
       CASE
         WHEN @Salary >60000 THEN (@Salary * 10.0/100)
         ELSE (@Salary * 5.0/100)
       END) >55000
    THEN 'HIGH NET'
    ELSE 'LOW NET'
END
END;

-- TESTING FUNCTION
SELECT Employee.EmpName,
       Employee.Salary,
       dbo.NetSalaryCategory(Salary) AS NetCategory
FROM Employee;

/* -----------
   DEPARTMENT BASED BONUS + CLASSIFICATION FUNCTIONS
 -------------   */

/* BONUS BASED ON DEPARTMENT AND FINAL CLASSIFICATION */

CREATE FUNCTION AddBonusClassify
   (@Salary INT, 
    @Department VARCHAR(20))
RETURNS VARCHAR (50)
AS
BEGIN
RETURN
CASE 
   WHEN (@Salary +
         CASE
              WHEN @Department = 'IT' THEN 10000
              WHEN @Department = 'Finance' THEN 7000
              ELSE 3000
         END) > 70000
   THEN 'Premium Employee'
   ELSE 'Standard Employee'
END
END;

-- TESTING FUNCTION
SELECT Employee.EmpName,
       Employee.Salary,
       dbo.AddBonusClassify(Salary,Department) AS EmployeeCategory
FROM Employee;

/* PERCENTAGE BONUS BASED ON DEPARTMENT */

CREATE FUNCTION AddPerBonusClassify
 ( @Department VARCHAR(20),
   @Salary INT )
RETURNS VARCHAR(20)
AS
BEGIN
RETURN 
CASE 
    WHEN (@Salary +
          CASE 
              WHEN @Department = 'IT' THEN (@Salary * 20.0/100)
              WHEN @Department = 'Finance' THEN (@Salary * 15.0/100)
              WHEN @Department = 'HR' THEN (@Salary * 10.0/100)
              ELSE (@Salary * 5.0/100)
          END) > 80000 THEN 'EXECUTIVE LEVEL'

    WHEN (@Salary +
          CASE 
              WHEN @Department = 'IT' THEN (@Salary * 20.0/100)
              WHEN @Department = 'Finance' THEN (@Salary * 15.0/100)
              WHEN @Department = 'HR' THEN (@Salary * 10.0/100)
              ELSE (@Salary * 5.0/100)
          END) BETWEEN 60000 AND 80000 THEN 'MID LEVEL'
    ELSE 'ENTRY LEVEL'
END
END;

-- TESTING FUNCTION
SELECT Employee.EmpName,
       Employee.Salary,
       dbo.AddPerBonusClassify(Department,Salary) AS EmployeeCategory
FROM Employee;

/* ---FINAL SALARY AFTER BONUS AND TAX CALCULATION */

CREATE FUNCTION FinalSalaryCalculation
(
 @Department VARCHAR(20),
 @Salary INT
)
RETURNS VARCHAR(50)
AS
BEGIN
RETURN
CASE 
  WHEN ((@Salary +  
         CASE 
           WHEN @Department = 'IT' THEN (@Salary * 15.0/100)
           WHEN @Department = 'Finance' THEN (@Salary * 10.0/100)
           WHEN @Department = 'HR' THEN (@Salary * 5.0/100)
           ELSE (@Salary * 2.0/100)
         END)
         -
         (CASE
           WHEN @Salary > 70000 THEN (@Salary * 10.0/100)
           ELSE (@Salary * 5.0/100)
         END)) >75000
  THEN 'TOP EMPLOYEE'

  WHEN ((@Salary +  
         CASE 
           WHEN @Department = 'IT' THEN (@Salary * 15.0/100)
           WHEN @Department = 'Finance' THEN (@Salary * 10.0/100)
           WHEN @Department = 'HR' THEN (@Salary * 5.0/100)
           ELSE (@Salary * 2.0/100)
         END)
         -
         (CASE
           WHEN @Salary > 70000 THEN (@Salary * 10.0/100)
           ELSE (@Salary * 5.0/100)
         END)) BETWEEN 60000 AND 75000
  THEN 'GOOD EMPLOYEE'

  ELSE 'AVERAGE EMPLOYEE'
END
END;

/* ---------
   STRING FUNCTIONS
   --------- */

-- EMPLOYEE NAME IN UPPERCASE
SELECT Employee.EmpName, UPPER(Employee.EmpName) AS UpperCaseName
FROM Employee;

-- EMPLOYEE NAME IN LOWERCASE
SELECT Employee.EmpName, LOWER(Employee.EmpName) AS LowerCaseName
FROM Employee;

-- LENGTH OF EMPLOYEE NAME
SELECT Employee.EmpName, LEN(Employee.EmpName) AS CharacterLength
FROM Employee;

-- FIRST 2 CHARACTERS OF NAME
SELECT Employee.EmpName, LEFT(Employee.EmpName, 2) AS First2Character
FROM Employee;

-- LAST 2 CHARACTERS OF NAME
SELECT Employee.EmpName, RIGHT(Employee.EmpName, 2) AS Right2Character
FROM Employee;

-- SUBSTRING FROM NAME
SELECT Employee.EmpName, SUBSTRING(Employee.EmpName, 2,4) AS CharacterLen2
FROM Employee;

/*----------
   FILTERING USING LIKE
  ----------  */

-- EMPLOYEES WHOSE NAME STARTS WITH A
SELECT Employee.EmpName, Employee.Salary
FROM Employee
WHERE EmpName LIKE 'A%';

-- NAME STARTS WITH A AND LENGTH > 4
SELECT Employee.EmpName, Employee.Salary
FROM Employee
WHERE LEN(Employee.EmpName) > 4 AND Employee.EmpName LIKE 'A%';

-- NAME ENDS WITH A
SELECT Employee.EmpName, Employee.Department
FROM Employee
WHERE Employee.EmpName LIKE '%a';

-- NAME CONTAINS A AND SALARY > 55000
SELECT Employee.EmpName, Employee.Salary
FROM Employee
WHERE Employee.EmpName LIKE '%a%' AND Employee.Salary > 55000;

/* ---------
   AGGREGATE FUNCTIONS
  --------- */

-- TOTAL EMPLOYEES
SELECT COUNT(Employee.EmpName) AS NumberofEmployee
FROM Employee;

-- TOTAL SALARY
SELECT SUM(Employee.Salary) AS TotalSalary
FROM Employee;

-- AVERAGE SALARY
SELECT AVG(Employee.Salary) AS AverageSalary
FROM Employee;

-- HIGHEST SALARY
SELECT MAX(Employee.Salary) AS HighestSalary
FROM Employee;

-- LOWEST SALARY
SELECT MIN(Employee.Salary) AS LowestSalary
FROM Employee;

/* --------
   GROUP BY AND HAVING
   -------- */

-- TOTAL SALARY PER DEPARTMENT
SELECT Employee.Department, SUM(Employee.Salary) AS TotalSalary
FROM Employee
GROUP BY Employee.Department;

-- EMPLOYEE COUNT PER DEPARTMENT
SELECT Employee.Department, COUNT(Employee.EmpName) AS NumberofEmployees
FROM Employee
GROUP BY Employee.Department;

-- AVERAGE SALARY PER DEPARTMENT
SELECT Employee.Department, AVG(Employee.Salary) AS AverageSalary
FROM Employee
GROUP BY Employee.Department;

-- DEPARTMENTS HAVING TOTAL SALARY > 100000
SELECT Employee.Department , SUM(Employee.Salary) AS TotalSalary
FROM Employee
GROUP BY Employee.Department
HAVING SUM(Employee.Salary) > 100000;

-- DEPARTMENTS HAVING MORE THAN 1 EMPLOYEE
SELECT Employee.Department, COUNT(Employee.EmpName) AS NumberofEmployee
FROM Employee
GROUP BY Employee.Department
HAVING COUNT(Employee.EmpName) > 1;
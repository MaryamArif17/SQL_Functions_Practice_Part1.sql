-- CREATING DATABASE

CREATE DATABASE FunctionPractice;
USE FunctionPractice;

-- CREATING TABLE

CREATE TABLE Employee (
EmpID INT PRIMARY KEY,
EmpName VARCHAR(20),
Salary INT,
Department VARCHAR(20)
);

-- INSERTING VALUES INTO TABLE

INSERT INTO Employee VALUES
(1, 'Ali', 50000, 'HR'),
(2, 'Sara', 65000, 'IT'),
(3, 'Usman', 70000, 'Finance'),
(4, 'Ayesha', 55000, 'IT');

-- DISPLAYING ALL EMPLOYEE RECORDS

SELECT * FROM Employee;


------------------------//SINGLE VALUED FUNCTIONS//-----------------------------------------

-- FUNCTION: ADD FIXED BONUS TO SALARY

CREATE FUNCTION AddBonus ( @Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary + 5000
END;

-- TESTING FUNCTION WITH MANUAL VALUE

SELECT dbo.AddBonus(3000) AS UpdatedSalary;

-- APPLYING BONUS FUNCTION ON EMPLOYEE TABLE

SELECT Employee.EmpName, Employee.Salary, dbo.AddBonus(Salary) AS UpdatedSalary 
FROM Employee;

-- FUNCTION: DEDUCT FIXED AMOUNT FROM SALARY

CREATE FUNCTION DeductSalary(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary - 10000
END;

-- APPLYING DEDUCTION FUNCTION

SELECT Employee.EmpName, Employee.Salary, dbo.DeductSalary(Salary)
AS UpdatedSalary
FROM Employee;

-- FUNCTION: INCREASE SALARY BY 10 PERCENT

CREATE FUNCTION IncreaseSalary(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary + (@Salary * 10/100)
END;

-- APPLYING 10% INCREASE FUNCTION

SELECT Employee.EmpName, Employee.Salary, dbo.IncreaseSalary(Salary)
AS UpdatedSalary
FROM Employee;

-- FUNCTION: CALCULATE ANNUAL SALARY

CREATE FUNCTION CalculateAnnual(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary * 12
END;

-- GETTING ANNUAL SALARY FROM MONTHLY SALARY

SELECT Employee.EmpName,
 Employee.Salary, 
 dbo.CalculateAnnual(Salary)
AS AnnualSalary
FROM Employee;

-- FUNCTION: DEDUCT 5 PERCENT TAX

CREATE FUNCTION DeductTAX(@Salary INT)
RETURNS INT
AS
BEGIN
RETURN @Salary -(@Salary * 5/100)
END;

-- APPLYING TAX DEDUCTION FUNCTION

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.DeductTAX(Salary) AS UpdatedSalary
FROM Employee;

----------------------------------//CASE FUNCTIONS/------------------------------------

-- FUNCTION: CLASSIFY SALARY INTO HIGH OR LOW CATEGORY

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

-- DISPLAY SALARY CATEGORY

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.SalaryCategory(Salary) AS SalaryCategory
FROM Employee;

-- FUNCTION: BONUS CATEGORY BASED ON SALARY RANGE

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

-- DISPLAY BONUS CATEGORY

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.BonusCategory(Salary) AS BonusCategory
FROM Employee;

----------------------------------//NESTED CASE FUNCTIONS//-----------------------------------

-- FUNCTION: NET SALARY AFTER TAX AND CLASSIFICATION

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
               END)
           >55000 THEN 'HIGH NET'
    ELSE 'LOW NET'
END
END;

-- DISPLAY NET SALARY CATEGORY

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.NetSalaryCategory(Salary) AS NetCategory
FROM Employee;

-- FUNCTION: BONUS BASED ON DEPARTMENT AND CLASSIFICATION

CREATE FUNCTION AddBonusClassify
   (@Salary INT, 
    @Department VARCHAR)
RETURNS VARCHAR (50)
AS
BEGIN
RETURN
CASE 
   WHEN 
       ( @Salary +
               CASE
                    WHEN @Department = 'IT' THEN 10000
                    WHEN @Department = 'Finance' THEN 7000
                    ELSE 3000
               END) 
          > 70000 THEN 'Premium Employee'
          ELSE 'Standard Employee'
END
END;

-- APPLYING DEPARTMENT BONUS CLASSIFICATION

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.AddBonusClassify(Salary,Department) AS EmployeeCategory
FROM Employee;

-- FUNCTION: BONUS PERCENTAGE BASED CLASSIFICATION

CREATE FUNCTION AddPerBonusClassify
 ( @Department VARCHAR(20),
   @Salary INT
 )
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
          END)
    > 80000 THEN 'EXECUTIVE LEVEL'

    WHEN (@Salary +
          CASE 
              WHEN @Department = 'IT' THEN (@Salary * 20.0/100)
              WHEN @Department = 'Finance' THEN (@Salary * 15.0/100)
              WHEN @Department = 'HR' THEN (@Salary * 10.0/100)
              ELSE (@Salary * 5.0/100)
          END)
    BETWEEN 60000 AND 80000 THEN 'MID LEVEL'
    ELSE 'ENTRY LEVEL'
END
END;

-- APPLYING BONUS PERCENTAGE CLASSIFICATION

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.AddPerBonusClassify(Department,Salary) AS EmployeeCategory
FROM Employee;

-- FUNCTION: FINAL SALARY AFTER BONUS AND TAX

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

-- APPLYING FINAL SALARY FUNCTION

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.FinalSalaryCalculation(Department,Salary) AS EmployeeCategory
FROM Employee;

-- FUNCTION: PERFORMANCE BASED CLASSIFICATION

CREATE FUNCTION PerformanceCategory
( @Department VARCHAR(20),
  @Salary INT
)
RETURNS VARCHAR(50)
AS
BEGIN
RETURN
CASE
 WHEN ((@Salary +
   CASE
    WHEN @Department ='IT' AND @Salary > 60000 THEN (@Salary * 20.0/100)
    WHEN @Department = 'Finance' THEN (@Salary * 12.0/100)
    WHEN @Department = 'HR' THEN (@Salary * 8.0/100)
    ELSE (@Salary * 5.0/100)
   END)
   -
   (CASE
     WHEN @Salary > 75000 THEN (@Salary * 12.0/100)
     WHEN @Salary BETWEEN 50000 AND 75000 THEN (@Salary * 7.0/100)
     ELSE (@Salary * 3.0/100)
    END)) > 85000 
    THEN 'OUTSTANDING'

 WHEN ((@Salary +
   CASE
    WHEN @Department ='IT' AND @Salary > 60000 THEN (@Salary * 20.0/100)
    WHEN @Department = 'Finance' THEN (@Salary * 12.0/100)
    WHEN @Department = 'HR' THEN (@Salary * 8.0/100)
    ELSE (@Salary * 5.0/100)
   END)
   -
   (CASE
     WHEN @Salary > 75000 THEN (@Salary * 12.0/100)
     WHEN @Salary BETWEEN 50000 AND 75000 THEN (@Salary * 7.0/100)
     ELSE (@Salary * 3.0/100)
    END)) BETWEEN 65000 AND 85000
    THEN 'GOOD PERFORMANCE'
  ELSE 'AVERAGE PERFORMANCE'
END
END;

-- APPLYING PERFORMANCE FUNCTION

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.PerformanceCategory(Department,Salary) AS PerformanceCategory
FROM Employee;

-- FUNCTION: FINAL EMPLOYEE STATUS

CREATE FUNCTION EmployeeStatus 
(@Department VARCHAR(20),
 @Salary INT
)
RETURNS VARCHAR(50)
AS
BEGIN
RETURN
CASE
 WHEN ((@Salary +
        CASE
         WHEN @Department = 'IT' AND @Salary > 70000 THEN (@Salary * 20.0/100)
         WHEN @Department = 'IT' AND @Salary <= 70000 THEN (@Salary * 18.0/100)
         WHEN @Department = 'Finance' OR @Department = 'HR' THEN (@Salary * 10.0/100)
         ELSE (@Salary * 4.0/100)
         END)
         -
         (CASE
          WHEN @Salary > 85000 THEN (@Salary * 15.0/100)
          WHEN @Salary BETWEEN 60000 AND 85000 THEN (@Salary * 8.0/100)
          ELSE (@Salary * 4.0/100)
          END)) > 95000 
        THEN 'ELITE EMPLOYEE'

       WHEN ((@Salary +
        CASE
         WHEN @Department = 'IT' AND @Salary <= 70000 THEN (@Salary * 18.0/100)
         WHEN @Department = 'Finance' OR @Department = 'HR' THEN (@Salary * 10.0/100)
         ELSE (@Salary * 4.0/100)
         END)
         -
         (CASE
          WHEN @Salary > 85000 THEN (@Salary * 15.0/100)
          WHEN @Salary BETWEEN 60000 AND 85000 THEN (@Salary * 8.0/100)
          ELSE (@Salary * 4.0/100)
          END)) BETWEEN 70000 AND 95000
        THEN 'PROFESSIONAL EMPLOYEE'
        ELSE 'REGULAR EMPLOYEE'
END
END;

-- APPLYING FINAL STATUS FUNCTION

SELECT Employee.EmpName,
       Employee.Salary,
       dbo.EmployeeStatus(Department,Salary) AS EmployeeStatus
FROM Employee;

-----------------------------// STRING FUNCTIONS------------------------------------------------

SELECT Employee.EmpName, UPPER(Employee.EmpName) AS UpperCaseName
FROM Employee;

SELECT Employee.EmpName, LOWER(Employee.EmpName) AS LowerCaseName
FROM Employee;

SELECT Employee.EmpName, LEN(Employee.EmpName) AS CharacterLength
FROM Employee;

SELECT Employee.EmpName, LEFT(Employee.EmpName, 2) AS First2Character
FROM Employee;

SELECT Employee.EmpName, RIGHT(Employee.EmpName, 2) AS Right2Character
FROM Employee;

SELECT Employee.EmpName, SUBSTRING(Employee.EmpName, 2,4) AS CharacterLen2
FROM Employee;

SELECT Employee.EmpName,
  LEN(Employee.EmpName) AS CharacterLen, 
  SUBSTRING(Employee.EmpName,1,3) AS First3Character,
  RIGHT(Employee.EmpName,2) AS Last2Character
FROM Employee;

--------------------------------// FILTERING USING LIKE//--------------------------------------

SELECT Employee.EmpName, Employee.Salary
FROM Employee
WHERE EmpName LIKE 'A%';

SELECT Employee.EmpName, Employee.Salary
FROM Employee
WHERE LEN(Employee.EmpName) > 4 AND Employee.EmpName LIKE 'A%';

SELECT Employee.EmpName, Employee.Department
FROM Employee
WHERE Employee.EmpName LIKE '%a';

SELECT Employee.EmpName, Employee.Salary
FROM Employee
WHERE Employee.EmpName LIKE '%a%' AND Employee.Salary > 55000;

SELECT Employee.EmpName, Employee.Department
FROM Employee
WHERE Employee.EmpName LIKE 'A%' AND LEN(Employee.EmpName) > 5;

--------------------------------------// AGGREGATE FUNCTIONS//----------------------------------

SELECT COUNT(Employee.EmpName) AS NumberofEmployee
FROM Employee;

SELECT SUM(Employee.Salary) AS TotalSalary
FROM Employee;

SELECT AVG(Employee.Salary) AS AverageSalary
FROM Employee;

SELECT MAX(Employee.Salary) AS HighestSalary
FROM Employee;

SELECT MIN(Employee.Salary) AS LowestSalary
FROM Employee;

---------------------// GROUP BY QUERIES//-------------------------------------

SELECT Employee.Department, SUM(Employee.Salary) AS TotalSalary
FROM Employee
GROUP BY Employee.Department;

SELECT Employee.Department, COUNT(Employee.EmpName) AS NumberofEmployees
FROM Employee
GROUP BY Employee.Department;

SELECT Employee.Department, AVG(Employee.Salary) AS AverageSalary
FROM Employee
GROUP BY Employee.Department;

----------------------------// HAVING CLAUSE QUERIES//----------------------------------------

SELECT Employee.Department , SUM(Employee.Salary) AS TotalSalary
FROM Employee
GROUP BY Employee.Department
HAVING SUM(Employee.Salary) > 100000;

SELECT Employee.Department, COUNT(Employee.EmpName) AS NumberofEmployee
FROM Employee
GROUP BY Employee.Department
HAVING COUNT(Employee.EmpName) > 1; 
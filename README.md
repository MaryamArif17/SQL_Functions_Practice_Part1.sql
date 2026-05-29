# SQL User Defined Functions Practice Project

## Overview

This project contains my complete practice work on SQL Server user-defined functions and related SQL concepts.  
It includes single-valued functions, nested functions, string functions, aggregate functions, and grouping queries.

The goal of this project is to strengthen my SQL logic building skills and understand how real-world salary, bonus, and classification systems work using SQL functions.

---

## Database Used

**Database Name:** FunctionPractice

The database contains a single table:

### Employee Table

| Column Name | Data Type |
|-------------|----------|
| EmpID       | INT (Primary Key) |
| EmpName     | VARCHAR(20) |
| Salary      | INT |
| Department  | VARCHAR(20) |

---

## Topics Covered

### 1. Single-Valued Functions
- AddBonus
- DeductSalary
- IncreaseSalary
- CalculateAnnual
- DeductTAX

These functions perform basic arithmetic operations on salary values.

---

### 2. CASE-Based Functions
- SalaryCategory
- BonusCategory

These functions classify employees based on salary ranges.

---

### 3. Nested Functions
- NetSalaryCategory
- AddBonusClassify
- AddPerBonusClassify
- FinalSalaryCalculation
- PerformanceCategory
- EmployeeStatus

These functions combine multiple conditions like:
- Department-based bonus rules
- Tax deductions
- Final salary classification

---

### 4. String Functions
- UPPER()
- LOWER()
- LEN()
- LEFT()
- RIGHT()
- SUBSTRING()

Used to analyze and manipulate employee names.

---

### 5. Pattern Matching (LIKE Operator)
- Filtering names starting with specific letters
- Filtering based on salary conditions
- Combined conditions using AND

---

### 6. Aggregate Functions
- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()

Used for overall salary and employee statistics.

---

### 7. GROUP BY & HAVING
- Department-wise salary totals
- Employee counts per department
- Filtering grouped results using HAVING clause

---

## Key Learning Outcomes

Through this project, I learned:

- How to write and structure SQL user-defined functions
- How to use nested CASE logic effectively
- How to apply business logic using SQL
- How to analyze data using aggregate functions
- How to group and filter data logically

---

## Project Purpose

This project is part of my SQL learning journey.  
It represents my practice from basic to intermediate level SQL logic building.

---

## Future Improvements

I will continue this project by adding:
- Table-Valued Functions
- Stored Procedures
- Joins and Advanced Query Optimization
- Real-world case study projects

---

## Author

This project is created as part of my SQL practice and learning progression.

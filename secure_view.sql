-- This script creates secure views for the two general views created earlier.
-- my_organization ==> This secure view is on top of employee_hierarchy view and is assigned to MANAGER and EMPLOYEE roles
-- employees_org   ==> This secure view is on top of employees view and is assigned to HR_GENERALIST and HR_OPS roles

--Secure Views

USE ROLE sysadmin;

-- This view is for managers and their associates
CREATE OR REPLACE SECURE VIEW my_organization 
AS SELECT * FROM employee_hierarchy ;


-- This view is for HR members
CREATE OR REPLACE SECURE VIEW employees_org 
AS SELECT * FROM employees ;



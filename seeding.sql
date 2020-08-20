-- Creating a database and schema for storing data for this use case.

use role sysadmin;

CREATE DATABASE customer_db;

USE DATABASE customer_db;

CREATE SCHEMA cust_mdm;

USE SCHEMA cust_mdm;

-- Creating the deptarment master data
CREATE TABLE dept(  
  deptno     NUMBER(2,0) NOT NULL,  
  dname      VARCHAR2(14) NOT NULL,  
  loc        VARCHAR2(13) NOT NULL,  
  CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO)  
);

-- Creating the employee master data, containing few  sensitive columns such as salary and commission.
-- This table also stores hierarchy amongst the manager and their associates.
CREATE TABLE emp(  
  empno    NUMBER(4,0) NOT NULL,  
  ename    VARCHAR2(10) NOT NULL,  
  job      VARCHAR2(9) NOT NULL,  
  mgr      NUMBER(4,0),  
  hiredate DATE NOT NULL,  
  sal      NUMBER(7,2) NOT NULL,  
  comm     NUMBER(7,2),  
  deptno   NUMBER(2,0) NOT NULL,  
  CONSTRAINT pk_emp PRIMARY KEY (empno),  
  CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)  
);

-- Inserting data into deptartments table
INSERT INTO dept (deptno, dname, loc)
VALUES
    (10, 'ACCOUNTING', 'NEW YORK'),
    (20, 'RESEARCH', 'DALLAS'),
    (30, 'SALES', 'CHICAGO'),
    (40, 'OPERATIONS', 'BOSTON');

-- Inserting data into employee table.
INSERT INTO emp  
VALUES
    ( 7839, 'KING',   'PRESIDENT', null,  to_date('17-11-1981', 'dd-mm-yyyy'),  5000, null, 10 ),
    ( 7698, 'BLAKE',  'MANAGER',   7839,  to_date('1-5-1981',   'dd-mm-yyyy'),  2850, null, 30 ),
    ( 7782, 'CLARK',  'MANAGER',   7839,  to_date('9-6-1981',   'dd-mm-yyyy'),  2450, null, 10 ),
    ( 7566, 'JONES',  'MANAGER',   7839,  to_date('2-4-1981',   'dd-mm-yyyy'),  2975, null, 20 ),
    ( 7788, 'SCOTT',  'ANALYST',   7566,  to_date('13-07-1987', 'dd-mm-yyyy'),  3000, null, 20 ),
    ( 7902, 'FORD',   'ANALYST',   7566,  to_date('3-12-1981',  'dd-mm-yyyy'),  3000, null, 20 ),
    ( 7369, 'SMITH',  'CLERK',     7902,  to_date('17-12-1980', 'dd-mm-yyyy'),  80,0, null, 20 ),
    ( 7499, 'ALLEN',  'SALESMAN',  7698,  to_date('20-2-1981',  'dd-mm-yyyy'),  1600, 300, 30  ),
    ( 7521, 'WARD',   'SALESMAN',  7698,  to_date('22-2-1981',  'dd-mm-yyyy'),  1250, 500, 30  ),
    ( 7654, 'MARTIN', 'SALESMAN',  7698,  to_date('28-9-1981',  'dd-mm-yyyy'),  1250, 1400, 30 ),
    ( 7844, 'TURNER', 'SALESMAN',  7698,  to_date('8-9-1981',   'dd-mm-yyyy'),  1500, 0, 30    ),
    ( 7876, 'ADAMS',  'CLERK',     7788,  to_date('13-7-1987',  'dd-mm-yyyy'),  1100, null, 20 ),
    ( 7900, 'JAMES',  'CLERK',     7698,  to_date('3-12-1981',  'dd-mm-yyyy'),  950, null, 30  ),
    ( 7934, 'MILLER', 'CLERK',     7782,  to_date('23-1-1982',  'dd-mm-yyyy'),  1300, null, 10 );

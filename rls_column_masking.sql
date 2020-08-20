-- This script creates 
-- ==>  a mapping table to enable row level security
--      i.e. Managers will be able to see their reportees' details including their salary information.
--      Non-managers will not be able see any info other than their own.
-- ==> A column masking policy which prevents an user logged in with HR_OPS role from viewing salary and commission of the associates. 
use role sysadmin;

CREATE OR REPLACE TABLE role_mapping_table ( employee_id int, login_id varchar, role_name VARCHAR);

INSERT INTO role_mapping_table VALUES 
(7698,'A7698', 'MANAGER'), 
(7839,'A7839', 'MANAGER'),
(7782,'A7782', 'MANAGER'),
(7566,'A7566', 'MANAGER'),
(7788,'A7788', 'MANAGER'),
(7902,'A7902', 'MANAGER'),
(7499,'A7499', 'EMPLOYEE'),
(7521,'A7521', 'EMPLOYEE'),
(7654,'A7654', 'EMPLOYEE'),
(7844,'A7844', 'EMPLOYEE');


-- Enabling column masking to ensure sensitive information like salary and commission is not shown to un-intended users
CREATE OR REPLACE MASKING POLICY salary_mask AS (sal INT) RETURNS INT ->
  CASE
    WHEN current_role() IN ('HR_GENERALIST') THEN sal
    ELSE NULL
  END;

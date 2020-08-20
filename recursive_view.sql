-- This script creates two database views which get accessed by associates who log into the snowflake UI. 
-- View Name: employee_hierarchy => Displays the details of logged-in associate and details of the associate's reportees if the associate is a manager.
--                                  This view joins with the role_mapping_table to restrict the records that must be visible to the logged-in associate.
--            employees          => Displays the details of all the associates in the system viewable by the HR personnel.

use role sysadmin;

CREATE OR REPLACE VIEW employee_hierarchy 
(   employee_id, 
    employee_name,
    employee_job,
    manager_id, 
    manager_name,
    manager_job,
    department_name,
    location,
    salary,
    commission
)
AS 
    (
        WITH RECURSIVE managers 
                -- Column names for the "view"/CTE
                (employee_id, 
                 employee_name,
                 employee_job,
                 manager_id, 
                 manager_name,
                 manager_job,
                 department_id,
                 salary,
                 commission) 
        AS
            -- Common Table Expression
            (
              -- Anchor Clause
              SELECT e.empno AS employee_id, 
                     e.ename AS employee_name, 
                     e.job   AS employee_job, 
                     NVL(e.mgr,0)  AS manager_id,
                     NVL(mg.ename,'NULL')  AS manager_name,
                     NVL(mg.job, 'NULL')  AS manager_job,
                     e.deptno AS department_no,
                     e.sal    AS salary,
                     e.comm   AS commission
                FROM emp e LEFT OUTER JOIN emp mg
                  ON ( e.mgr = mg.empno)
                WHERE employee_id = ( SELECT rmt.employee_id FROM role_mapping_table rmt
                                      WHERE rmt.role_name  = current_role() 
                                        AND rmt.login_id = current_user() )

                UNION ALL

                -- Recursive Clause
                SELECT emp.empno, 
                     emp.ename,  
                     emp.job, 
                     TO_NUMBER(emp.mgr) AS manager_id,
                     managers.employee_name, 
                     managers.employee_job,
                     emp.deptno,
                     emp.sal,
                     emp.comm
                FROM emp JOIN managers 
                  ON emp.mgr = managers.employee_id
            )
            SELECT  employee_id::int, 
                    employee_name::varchar,
                    employee_job::varchar,
                    manager_id::int, 
                    manager_name::varchar,
                    manager_job::varchar,
                    dname::varchar AS department_name,
                    loc::varchar AS location,
                    salary::decimal,
                    commission::decimal
            FROM managers, dept
            WHERE dept.deptno = managers.department_id
    );
  
select * from employee_hierarchy;

CREATE OR REPLACE VIEW employees
(   employee_id, 
    employee_name,
    employee_job,
    manager_id, 
    manager_name,
    manager_job,
    department_name,
    location,
    salary,
    commission
)
AS 
    (
        WITH RECURSIVE managers 
                -- Column names for the "view"/CTE
                (employee_id, 
                 employee_name,
                 employee_job,
                 manager_id, 
                 manager_name,
                 manager_job,
                 department_id,
                 salary,
                 commission) 
        AS
            -- Common Table Expression
            (
              -- Anchor Clause
              SELECT e.empno AS employee_id, 
                     e.ename AS employee_name, 
                     e.job   AS employee_job, 
                     0  AS manager_id,
                     'NULL'  AS manager_name,
                     'NULL'  AS manager_job,
                     e.deptno AS department_no,
                     e.sal    AS salary,
                     e.comm   AS commission
                FROM emp e
                WHERE employee_job = 'PRESIDENT'

                UNION ALL

                -- Recursive Clause
                SELECT emp.empno, 
                     emp.ename,  
                     emp.job, 
                     TO_NUMBER(emp.mgr) AS manager_id,
                     managers.employee_name, 
                     managers.employee_job,
                     emp.deptno,
                     emp.sal,
                     emp.comm
                FROM emp JOIN managers 
                  ON emp.mgr = managers.employee_id
            )
            SELECT  employee_id::int, 
                    employee_name::varchar,
                    employee_job::varchar,
                    manager_id::int, 
                    manager_name::varchar,
                    manager_job::varchar,
                    dname::varchar AS department_name,
                    loc::varchar AS location,
                    salary::decimal,
                    commission::decimal
            FROM managers, dept
            WHERE dept.deptno = managers.department_id
    );

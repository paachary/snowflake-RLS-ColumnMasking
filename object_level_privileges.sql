-- This script 
-- ==> provides all the necessary privileges on the Warehouse, Database, Schema, Secure Views to the 4 roles created previously.
-- ==> assigns the column masking policy to the sensitive columns of employees views.

use role sysadmin;

GRANT USAGE ON WAREHOUSE compute_wh TO manager;
GRANT USAGE ON DATABASE customer_db TO manager;
GRANT USAGE ON SCHEMA cust_mdm      TO manager;
GRANT SELECT ON my_organization     TO manager;

GRANT USAGE ON WAREHOUSE compute_wh TO employee;
GRANT USAGE ON DATABASE customer_db TO employee;
GRANT USAGE ON SCHEMA cust_mdm      TO employee;
GRANT SELECT ON my_organization     TO employee;

GRANT SELECT ON employees_org       TO hr_generalist;
GRANT USAGE ON WAREHOUSE compute_wh TO hr_generalist;
GRANT USAGE ON DATABASE customer_db TO hr_generalist;
GRANT USAGE ON SCHEMA cust_mdm      TO hr_generalist;

GRANT SELECT ON employees_org TO HR_OPS;
GRANT USAGE ON WAREHOUSE compute_wh TO hr_ops;
GRANT USAGE ON DATABASE customer_db TO hr_ops;
GRANT USAGE ON SCHEMA cust_mdm      TO hr_ops;

ALTER VIEW employees MODIFY COLUMN salary     SET MASKING POLICY salary_mask;
ALTER VIEW employees MODIFY COLUMN commission SET MASKING POLICY salary_mask;

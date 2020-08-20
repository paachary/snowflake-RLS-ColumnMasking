# snowflake-RLS-ColumnMasking

This repository has setup scripts for demonstration of Row Level Security and Column Masking features in Snowflake.
This is synonymous to Oracle's VPD and Column Redaction features.

## Scripts

### seeding.sql 
--------------
1. Creates a database and schema for storing data for this use case.
2. Creates emp and dept tables and seeds sample data into those tables.
###### Note: Those familiar with Oracle's emp and dept tables, they will recognize these scripts and data.
The emp table stores hierarchy amongst the manager and their associates.

### rls_column_masking.sql
--------------------------
This script creates 
==>  a mapping table to enable row level security
      i.e. Managers will be able to see their reportees' details including their salary information.
      Non-managers will not be able see any info other than their own.
==> A column masking policy which prevents an user logged in with HR_OPS role from viewing salary and commission of the associates. 

### recursive_view.sql
------------------------
This script creates two database views which get accessed by associates who log into the snowflake UI. 
View Name: 
==> employee_hierarchy :
  ** Displays the details of logged-in associate and details of the associate's reportees if the associate is a manager.
  ** This view joins with the role_mapping_table to restrict the records that must be visible to the logged-in associate.

==> employees: Displays the details of all the associates in the system viewable by the HR personnel.

### secure_view.sql
--------------------
This script creates secure views for the two general views created earlier.
my_organization ==> This secure view is on top of employee_hierarchy view and is assigned 
to MANAGER and EMPLOYEE roles
employees_org   ==> This secure view is on top of employees view and is assigned 
to HR_GENERALIST and HR_OPS roles

### user_role_creation.sql
This script 
==> creates database users for the associates inserted into the emp table previously.
==> creates roles assigned to the associates ; MANAGER, EMPLOYEE, HR_GENERALIST and HR_OPS

### object_level_privileges.sql
--------------------------------
This script 
==> provides all the necessary privileges on the Warehouse, Database, Schema, Secure Views to the 4 roles created previously.
==> assigns the column masking policy to the sensitive columns of employees views.




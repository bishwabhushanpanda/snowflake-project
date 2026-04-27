

-- Step 1: Switch to PROD
USE DATABASE myproj_prod;
USE SCHEMA analytics;

-- Step 2: Stop tasks (safety)
ALTER TASK IF EXISTS task_sales SUSPEND;

-- Step 3: Deploy Stored Procedure
!source C:\Users\CZ0510\snowflake-project\procedures/sp_sales.sql;

-- Step 4: Deploy Task
!source C:\Users\CZ0510\snowflake-project\task/task_sales.sql;

-- Step 5: Resume task
ALTER TASK IF EXISTS task_sales RESUME;
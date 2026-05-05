CREATE OR REPLACE PROCEDURE sp_load_sales_py()
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.10'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'run'
AS
$$
from snowflake.snowpark import Session
from snowflake.snowpark.functions import col

def run(session: Session):

    try:
        # Read from staging table
        df = session.table("staging_sales")

        # Apply transformations
        df_clean = (
            df.filter(col("AMOUNT") > 0)      # remove invalid records
              .drop_duplicates()             # remove duplicates
        )

        # Load into final table (overwrite for now)
        df_clean.write.mode("overwrite").save_as_table("final_sales")

        return f"SUCCESS: Loaded {df_clean.count()} records into final_sales"

    except Exception as e:
        return f"FAILED: {str(e)}"
$$;
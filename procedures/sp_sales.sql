CREATE OR REPLACE PROCEDURE sp_sales()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    DELETE FROM sales_final;

    INSERT INTO sales_final
    SELECT 
        order_id,
        SUM(amount)
    FROM staging_sales
    WHERE order_date >= CURRENT_DATE - 3
    GROUP BY order_id;

    RETURN 'SUCCESS';
END;
$$;
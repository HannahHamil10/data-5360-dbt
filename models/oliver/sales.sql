
{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    f.ORDER_ID,
    f.ORDER_LINE_ID,

    c.FIRST_NAME AS CUSTOMER_FIRST_NAME,
    c.LAST_NAME AS CUSTOMER_LAST_NAME,
    c.STATE AS CUSTOMER_STATE,

    e.FIRST_NAME AS EMPLOYEE_FIRST_NAME,
    e.LAST_NAME AS EMPLOYEE_LAST_NAME,
    e.POSITION AS EMPLOYEE_POSITION,

    p.PRODUCT_NAME,
    p.DESCRIPTION AS PRODUCT_DESCRIPTION,

    s.STORE_NAME,
    s.CITY AS STORE_CITY,
    s.STATE AS STORE_STATE,

    d.DATE_DAY AS ORDER_DATE,
    d.MONTH_NAME,
    d.QUARTER_OF_YEAR,
    d.YEAR_NUMBER,

    f.QUANTITY,
    f.UNIT_PRICE,
    f.SALES_AMOUNT

FROM {{ ref('fact_sales') }} f

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.CUSTOMER_KEY = c.CUSTOMER_KEY

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.EMPLOYEE_KEY = e.EMPLOYEE_KEY

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON f.PRODUCT_KEY = p.PRODUCT_KEY

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON f.STORE_KEY = s.STORE_KEY

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.DATE_KEY = d.DATE_KEY

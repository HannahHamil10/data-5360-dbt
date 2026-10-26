
{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    ol.ORDER_LINE_ID AS SALES_KEY,
    o.ORDER_ID,
    ol.ORDER_LINE_ID,

    o.CUSTOMER_ID AS CUSTOMER_KEY,
    o.EMPLOYEE_ID AS EMPLOYEE_KEY,
    ol.PRODUCT_ID AS PRODUCT_KEY,
    o.STORE_ID AS STORE_KEY,
    o.ORDER_DATE AS DATE_KEY,

    ol.QUANTITY,
    ol.UNIT_PRICE,
    ol.QUANTITY * ol.UNIT_PRICE AS SALES_AMOUNT

FROM {{ source('oliver_landing', 'orderline') }} ol

INNER JOIN {{ source('oliver_landing', 'orders') }} o
    ON ol.ORDER_ID = o.ORDER_ID

INNER JOIN {{ ref('oliver_dim_customer') }} c
    ON o.CUSTOMER_ID = c.CUSTOMER_ID

INNER JOIN {{ ref('oliver_dim_employee') }} e
    ON o.EMPLOYEE_ID = e.EMPLOYEE_ID

INNER JOIN {{ ref('oliver_dim_product') }} p
    ON ol.PRODUCT_ID = p.PRODUCT_ID

INNER JOIN {{ ref('oliver_dim_store') }} s
    ON o.STORE_ID = s.STORE_ID

INNER JOIN {{ ref('oliver_dim_date') }} d
    ON o.ORDER_DATE = d.DATE_DAY

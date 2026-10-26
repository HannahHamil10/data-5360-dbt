
{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    PRODUCT_ID AS PRODUCT_KEY,
    PRODUCT_ID,
    PRODUCT_NAME,
    DESCRIPTION,
    UNIT_PRICE
FROM {{ source('oliver_landing', 'product') }}

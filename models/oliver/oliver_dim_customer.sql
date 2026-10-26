
{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    CUSTOMER_ID AS CUSTOMER_KEY,
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    STATE
FROM {{ source('oliver_landing', 'customer') }}


{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    STORE_ID AS STORE_KEY,
    STORE_ID,
    STORE_NAME,
    STREET,
    CITY,
    STATE
FROM {{ source('oliver_landing', 'store') }}

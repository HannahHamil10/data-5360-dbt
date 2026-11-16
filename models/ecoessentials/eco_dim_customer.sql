
{{ config(materialized='table') }}

WITH customers AS (

    SELECT
        customer_id,
        customer_first_name AS customer_firstname,
        customer_last_name AS customer_lastname,
        customer_email
    FROM {{ ref('stg_eco_customer') }}

    UNION ALL

    SELECT DISTINCT
        NULL AS customer_id,
        m.subscriber_first_name AS customer_firstname,
        m.subscriber_last_name AS customer_lastname,
        m.subscriber_email AS customer_email
    FROM {{ ref('stg_eco_marketing_emails') }} m
    WHERE NOT EXISTS (
        SELECT 1
        FROM {{ ref('stg_eco_customer') }} c
        WHERE
            (
                m.subscriber_email IS NOT NULL
                AND LOWER(TRIM(c.customer_email)) =
                    LOWER(TRIM(m.subscriber_email))
            )
    )
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            customer_firstname,
            customer_lastname,
            customer_email
    ) AS customer_key,
    customer_id,
    customer_firstname,
    customer_lastname,
    customer_email
FROM customers


{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    ec.CERTIFICATION_COMPLETION_ID,
    de.EMPLOYEE_KEY,
    dd.DATE_KEY,
    ec.CERTIFICATION_NAME,
    ec.CERTIFICATION_COST
FROM {{ ref('stg_employee_certifications') }} ec

LEFT JOIN {{ ref('oliver_dim_employee') }} de
    ON ec.EMPLOYEE_ID = de.EMPLOYEE_ID

LEFT JOIN {{ ref('oliver_dim_date') }} dd
    ON ec.CERTIFICATION_AWARDED_DATE = dd.DATE_DAY

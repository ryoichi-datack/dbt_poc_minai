{{ config( materialized='table' )}} -- point, tableとして作成することを指定

WITH
  actdata_c1_test AS (
    SELECT
      *
    FROM {{ ref('stg_pq_act') }} -- point
    WHERE procedure_code in (160056610, 160061810)
  ),

  patients AS (
    SELECT
      *
    FROM {{ ref('stg_patient') }} -- point2
  ),

  patients_with_c1_test  AS (
    SELECT DISTINCT
      patients.patient_id,
      patients.patient_birthdate,
      actdata.procedure_code
    FROM
      patients
      INNER JOIN
        actdata_c1_test AS actdata
        ON patients.patient_id = actdata.patient_id
  )

SELECT
  *
FROM patients_with_c1_test
;

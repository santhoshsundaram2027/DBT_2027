{{
    config(
            materialized = 'view'
          )
}}

select TRANSACTION_ID,
       CUSTOMER_ID,
       AMOUNT,
       UPPER(TRIM(TRANSACTION_TYPE)) as TRANSACTION_TYPE,
       TRANSACTION_DATE,
       FILE_NAME,
       LOAD_TIMESTAMP
from {{ source('raw','raw_transactions') }}
where TRANSACTION_ID is not null
and CUSTOMER_ID is not null
and AMOUNT > 0
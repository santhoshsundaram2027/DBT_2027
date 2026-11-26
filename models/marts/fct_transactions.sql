{{
    config (
             materialized = 'incremental',
             unique_key = 'Transaction_id',
             incremental_strategy='merge'
    )
}}

select TRANSACTION_ID,
       CUSTOMER_ID,
       AMOUNT,
       TRANSACTION_TYPE,
       TRANSACTION_DATE,
       FILE_NAME,
       LOAD_TIMESTAMP

FROM {{ ref('stg_transactions') }}

{% if is_incremental() %}

where LOAD_TIMESTAMP > dateadd(
                               day,-3,current_timestamp()
                               )

{% endif %}
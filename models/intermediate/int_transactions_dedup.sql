{{
    config(
            materialized = 'table'
    )
}}

select *
from {{ ref('stg_transactions') }}
qualify row_number() over(partition by TRANSACTION_ID
                          order by LOAD_TIMESTAMP asc
                         )=1
{{
    config (
             materialized = 'table'
    )
}}

select CUSTOMER_ID,
       to_date(TRANSACTION_DATE) as TRANSACTION_DAY,
       count(*) as Total_Transactions,
       sum( case
                when TRANSACTION_TYPE='CREDIT'
                Then AMOUNT
                else 0
            END    
          ) as TOTAL_CREDIT,
        sum(
             case
                 when TRANSACTION_TYPE='DEBIT'
                 Then AMOUNT
                 else 0
             END    
        )  as TOTAL_DEBIT
from {{  ref('fct_transactions') }}

group by CUSTOMER_ID,
         to_date(TRANSACTION_DATE)

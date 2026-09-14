-- 3. DATA QUALITY

-- 3.1 Check missing values in key credit variables
select count(*) as total_loans,
sum (case when loan_amnt is null then 1 else 0 end) as missing_loan_amnt,
sum (case when int_rate is null then 1 else 0 end) as missng_int_rate,
sum (case when grade is null then 1 else 0 end) as missing_grade,
sum (case when annual_inc is null then 1 else 0 end) as missing_annual_inc,
sum (case when dti is null then 1 else 0 end) as missing_dti,
sum (case when fico_range_low is null then 1 else 0 end) as missing_fico_range_low,
sum (case when fico_range_high is null then 1 else 0 end) as missing_fico_range_high,
sum (case when term is null then 1 else 0 end) as missing_term,
sum (case when purpose is null then 1 else 0 end) as missing_purpose,
sum (case when loan_status is null or loan_status = ' ' then 1 else 0 end) as missing_loan_status
from loans;

-- 5. Pricing Strategy Analysis

-- 5.1 Pricing differentiation by sub-grade
select l.sub_grade, count(*) as loan_count,
sum( case when o.outcome_group = 'Credit Loss / Default' then 1 else 0 end) as credit_loss_count,
round( sum( case when o.outcome_group = 'Credit Loss / Default' then 1 else 0 end) * 100.0 / Count(*), 2) as credit_loss_rate,
round( avg( l.int_rate), 2) as average_interest_rate
from loans as l
join loan_outcomes as o on l.id = o.id
where trim(l.sub_grade) <> ''
group by l.sub_grade
order by l.sub_grade;

-- 5.2 exposure weighted credit risk by sub grade
select l.sub_grade, count(*) as loan_count,
round(sum(l.loan_amnt), 0) as total_loan_amount,
round(sum(case when o.outcome_group = 'Credit Loss / Default' then l.loan_amnt else 0 end), 0) as credit_loss_exposure,
round(sum(case when o.outcome_group = 'Credit Loss / Default' then l.loan_amnt else 0 end) * 100.0 / sum(l.loan_amnt), 2) as credit_loss_exposure_rate,
round(avg(l.int_rate), 2) as average_interest_rate
from loans as l
join loan_outcomes as o on l.id = o.id
where trim(l.sub_grade) <> ''
group by l.sub_grade
order by l.sub_grade;

-- 5.3 Pricing changes by sub grade
with pricing_data as (
select l.sub_grade,
avg(l.int_rate) as average_interest_rate,
sum(case when o.outcome_group = 'Credit Loss / Default' then l.loan_amnt else 0 end) * 100.0 / sum(l.loan_amnt) as default_exposure_rate
from loans as l
join loan_outcomes as o on l.id = o.id
where trim(l.sub_grade) <> ''
group by l.sub_grade
),
pricing_changes as (
select sub_grade,
round(average_interest_rate, 2) as average_interest_rate,
round(default_exposure_rate, 2) as default_exposure_rate, 
round(average_interest_rate - lag(average_interest_rate) over (order by sub_grade), 2) as interest_rate_change,
round(default_exposure_rate - lag(default_exposure_rate) over (order by sub_grade), 2) as default_exposure_change
from pricing_data
)
select sub_grade,
average_interest_rate,
default_exposure_rate,
interest_rate_change,
default_exposure_change
from pricing_changes
order by sub_grade;

-- 5.4 Pricing Alignment flags
with pricing_data as (
select l.sub_grade,
round(avg(l.int_rate), 2) as average_interest_rate,
round(sum(case when o.outcome_group = 'Credit Loss / Default' then l.loan_amnt else 0 end) * 100.0 / sum(l.loan_amnt), 2) as default_exposure_rate
from loans as l
join loan_outcomes as o on l.id = o.id

group by l.sub_grade
),
pricing_changes as (
select sub_grade,
average_interest_rate,
default_exposure_rate,
round(average_interest_rate - lag(average_interest_rate) over (order by sub_grade), 2) as interest_rate_change,
round(default_exposure_rate - lag(default_exposure_rate) over (order by sub_grade), 2) as default_exposure_change
from pricing_data
)
select sub_grade,
average_interest_rate,
default_exposure_rate,
interest_rate_change,
default_exposure_change,
case
when default_exposure_change >= 2 and interest_rate_change < 1 then 'Under-pricing review'
when default_exposure_change <= -1 and interest_rate_change >= 0.5 then 'Potential over-pricing review'
else 'No flag'
end as pricing_flag
from pricing_changes
where trim(sub_grade) <> ''
order by sub_grade;

--5.5 Credit Loss Concentration by Grade
select l.grade,
count(*) as loan_count,
round(sum(l.loan_amnt), 2) as total_loan_amount,
round(sum(case when o.outcome_group = 'Credit Loss / Default' then l.loan_amnt else 0 end), 2) as credit_loss_amount,
round(sum(case when o.outcome_group = 'Credit Loss / Default' then l.loan_amnt else 0 end) * 100.0 / sum(l.loan_amnt), 2) as credit_loss_exposure_rate
from loans as l
join loan_outcomes as o on l.id = o.id
where trim(l.sub_grade) <> ''
group by l.grade
order by l.grade;

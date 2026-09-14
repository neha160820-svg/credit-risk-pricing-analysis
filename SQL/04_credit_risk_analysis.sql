-- 4. CREDIT RISK ANALYSIS

-- 4.1 Compare credit loss rate and pricing across LendingClub grades
with grade_analysis as (
select l.grade, count(*) as loan_count,
sum (case when o.outcome_group = 'Credit Loss / Default' then 1 else 0 end) as credit_loss_count,
round (avg(l.int_rate), 2) as average_interest_rate
from loans as l
join loan_outcomes as o on l.id = o.id
where trim(l.grade) <> ''
group by l.grade)
select grade, loan_count, credit_loss_count,
round (credit_loss_count * 100.0 / loan_count, 2) as credit_loss_rate, average_interest_rate
from grade_analysis
order by grade;

-- 4.2 Loan Term and Credit Risk 
with term_analysis as (
select l.term, count(*) as loan_count,
sum (case when o.outcome_group = 'Credit Loss / Default' then 1 else 0 end) as credit_loss_count,
round (avg(l.int_rate), 2) as average_interest_rate
from loans as l
join loan_outcomes as o on l.id = o.id
where trim(l.term) <> ''
group by l.term)
select term, loan_count, credit_loss_count,
round (credit_loss_count * 100.0 / loan_count, 2) as credit_loss_rate, average_interest_rate
from term_analysis
order by term;

-- 4.3 Compare credit risk across grade and loan term
with grade_term_analysis as(
select l.grade, l.term, count(*) as loan_count,
sum (case when o.outcome_group = 'Credit Loss / Default' then 1 else 0 end) as credit_loss_count,
round (avg(l.int_rate), 2) as average_interest_rate
from loans as l
join loan_outcomes as o on l.id = o.id
where trim(l.grade) <> '' and trim(l.term) <> ''
group by l.grade, l.term)
select grade, term, loan_count, credit_loss_count,
round (credit_loss_count * 100.0 / loan_count, 2) as credit_loss_rate, average_interest_rate
from grade_term_analysis
order by grade, term;

-- 4.4 Investigate borrower credit quality and debt burden by grade and term
with borrower_profile as(
select l.grade, l.term, count(*) as loan_count,
round(avg(l.fico_range_low), 0) as avg_fico_low,
round(avg(l.fico_range_high), 0) as avg_fico_high,
round(avg(l.dti), 2) as avg_dti
from loans as l
where trim(l.grade) <> '' and trim(l.term) <> ''
group by l.grade, l.term)
select grade, term, loan_count, avg_fico_low, avg_fico_high, avg_dti
from borrower_profile
order by grade, term;

-- 4.5 Borrower income and loan affordability by grade and term
with financial_profile as(
select l.grade, l.term, count(*) as loan_count,
round(avg(l.annual_inc), 0) as avg_annual_inc,
round(avg(l.loan_amnt), 0) as avg_loan_amnt,
round(avg(l.installment), 2) as avg_installment
from loans as l
where trim(l.grade) <> '' and trim(l.term) <> ''
group by l.grade, l.term)
select grade, term, loan_count,avg_annual_inc, avg_loan_amnt, avg_installment
from financial_profile
order by grade, term;

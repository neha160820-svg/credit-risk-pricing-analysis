-- 2. LOAN OUTCOME CLASSIFICATION

-- 2.1 Understand different outcomes of loans in the portfolio
select loan_status, count(*) as loan_count
from loans
group by loan_status
order by loan_count desc;

-- 2.2 Create a view that classifies each loan outcome
Create view loan_outcomes as
Select id, loan_status,
Case
When loan_status In ('Fully Paid', 'Does not meet the credit policy. Status:Fully Paid', 'Current') Then 'Performing'
When loan_status In ('In Grace Period', 'Late (16-30 days)', 'Late (31-120 days)') Then 'Delinquent / At Risk'
When loan_status In ('Charged Off', 'Default', 'Does not meet the credit policy. Status:Charged Off') Then 'Credit Loss / Default'
When loan_status Is NULL Or loan_status = '' Then 'Unknown' Else 'Other' End as outcome_group
From loans;
 
-- 2.3 Quantify loan_outcomes by count and portfolio percentage 
Select outcome_group, count(*) as loan_count, round(count(*) * 100.0 / (select count (*) from loan_outcomes), 2) as portfolio_percentage
from loan_outcomes
group by outcome_group
order by loan_count desc;

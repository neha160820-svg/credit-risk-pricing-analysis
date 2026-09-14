--Credit Risk & Pricing Strategy Analysis/ Lending Club Loan Dataset

-- 1. DATASET EXPLORATION & VALIDATION

-- 1.1 Inspect the structure of the loans table
PRAGMA table_info(loans);

-- 1.2 Inspect a small sample of important columns
select id, member_id, term, loan_amnt, int_rate
from loans
limit 5;

-- 1.3 Check total number of records and whether ids are unique
select count(*) as total_rows, count(distinct id) as diff_ids
from loans;

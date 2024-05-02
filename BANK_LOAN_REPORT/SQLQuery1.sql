use load_data;
select * from financial_loan;

-- total application
select COUNT(id) as total_applications from financial_loan;

-- latest month total applications
select COUNT(id) as MTD_total_applications from financial_loan
where MONTH(issue_date)=12 and YEAR(issue_date)=2021;

-- previous month to date 
select COUNT(id) as PMTD_total_applications from financial_loan
where MONTH(issue_date)=11 and YEAR(issue_date)=2021;

-- MOM(month over month) = (MTD-PMTD)/PMTD  (previous month to date)
select ((select COUNT(id) as MTD_total_applications from financial_loan
where MONTH(issue_date)=12 and YEAR(issue_date)=2021)-
(select COUNT(id) as PMTD_total_applications from financial_loan
where MONTH(issue_date)=11 and YEAR(issue_date)=2021)) /
(select COUNT(id) as PMTD_total_applications from financial_loan
where MONTH(issue_date)=11 and YEAR(issue_date)=2021)



-- Total Funded Amount
select SUM(loan_amount) as total_funded_amt from financial_loan;

-- MTD Total Funded Amount
select SUM(loan_amount) as MTD_total_funded_amt from financial_loan
where MONTH(issue_date)=12;

-- total amount received 
select SUM(total_payment) as total_received_amt from financial_loan;

-- MTD Total Amount Received
select SUM(total_payment) as MTD_total_received_amt from financial_loan
where MONTH(issue_date)=12;

-- Average Interest Rate
select ROUND(AVG(int_rate)*100,2) as avg_interest_rate from financial_loan;

-- MTD Average Interest
select ROUND(AVG(int_rate)*100,2) as mtd_avg_interest_rate from financial_loan
where MONTH(issue_date)=12;

-- All Month Average Interest
select MONTH(issue_date),) as month_name, ROUND(AVG(int_rate)*100,2) as mtd_avg_interest_rate from financial_loan
where YEAR(issue_date)=2021
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date) ASC;


select DATENAME(mm,issue_date) as month_name,ROUND(AVG(int_rate)*100,2) as mtd_avg_interest_rate from financial_loan
where YEAR(issue_date)=2021
GROUP BY DATENAME(mm,issue_date) ,MONTH(issue_date)
ORDER BY MONTH(issue_date);

-- Avg DTI
select AVG(dti)*100 as avg_dti from financial_loan;

-- MTD Avg DTI
select AVG(dti)*100 as mtd_avg_dti from financial_loan
where MONTH(issue_date)=12;

-- PMTD Avg DTI
select AVG(dti)*100 as pmtd_avg_dti from financial_loan
where MONTH(issue_date)=11;


-- Good Loan Percentage
select (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status='Current' THEN id END)*100.0)/
COUNT(id) as Good_loan_percentage 
FROM financial_loan;

-- Good Loan Application
select COUNT(id) as good_loan_application from financial_loan
where loan_status='Fully Paid' or loan_status='Current';

-- Good Loan Funded Amount
select SUM(loan_amount) as Good_Loan_Funded_amount  from financial_loan
where loan_status='Fully Paid' or loan_status='Current';

-- Good Loan Amount Received
select SUM(total_payment) as Good_Loan_amount_received  from financial_loan
where loan_status='Fully Paid' or loan_status='Current';

-- Bad Loan Percentage
select COUNT(CASE WHEN loan_status='Charged Off' THEN id END)*100.0 / 
COUNT(id) as Bad_Loan_Percentage
FROM financial_loan;

-- Bad Loan Applications
SELECT COUNT(id) as Bad_loan_application from financial_loan
where loan_status='Charged Off';

-- Bad Loan Funded Amount
select SUM(loan_amount) as bad_loan_funded_amount from financial_loan
where loan_status='Charged Off';

-- Bad Loan Amount Received
select SUM(total_payment) as bad_loan_amount_received from financial_loan
where loan_status='Charged Off';


-- LOAN STATUS
select loan_status,
COUNT(id) as total_application,
SUM(loan_amount) as total_amount_funded,
SUM(total_payment) as total_amount_received,
AVG(int_rate*100.0) as int_rate,
AVG(dti * 100.0) AS DTI
from financial_loan
GROUP BY loan_status;

-- loan status for MTD
select 
	loan_status,
	SUM(total_payment) as MTD_total_amt_funded,
	SUM(loan_amount) as MTD_total_amt_received
from financial_loan
where MONTH(issue_date)=12
group by loan_status;

select * from financial_loan;
-- BANK LOAN REPORT
-- Month wise
select 
	COUNT(id) as total_application,
	DATENAME(mm,issue_date) as Month_name,
	SUM(loan_amount) as loan_amount_funded,
	SUM(total_payment) as loan_amount_received
from financial_loan
group by DATENAME(mm,issue_date),MONTH(issue_date)
order by MONTH(issue_date);

-- state wise
select 
	COUNT(id) as total_application,
	address_state,
	SUM(loan_amount) as loan_amount_funded,
	SUM(total_payment) as loan_amount_received
from financial_loan
group by address_state
order by address_state;

-- term wise
select 
	COUNT(id) as total_application,
	term,
	SUM(loan_amount) as loan_amount_funded,
	SUM(total_payment) as loan_amount_received
from financial_loan
group by term
order by term;

-- based on emp length
select
	COUNT(id) as total_application,
	emp_length,
	SUM(loan_amount) as loan_amount_funded,
	SUM(total_payment) as loan_amount_received
from financial_loan
group by emp_length
order by emp_length;

-- based on purpose
select
	COUNT(id) as total_application,
	purpose,
	SUM(loan_amount) as loan_amount_funded,
	SUM(total_payment) as loan_amount_received
from financial_loan
group by purpose
order by purpose;

-- based on home ownership
select
	COUNT(id) as total_application,
	home_ownership,
	SUM(loan_amount) as loan_amount_funded,
	SUM(total_payment) as loan_amount_received
from financial_loan
group by home_ownership 
order by home_ownership ;

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;



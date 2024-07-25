
-- Created New Database
Create database Project;
use Project ;
Select * from hr1;
Select * from hr2;

-- Fetched the Count of Total Employee's
select count(*) employeenumber from hr1;
------------------------------------------------

-- Fetched the details of Gender
create view gender as
select gender, count(gender) Count_gender from hr1
group by gender;
select * from gender;
--------------------------------------------------

-- Fetched the details of Attriation Employee's
select count(attrition)  from hr1 where Attrition = "yes";
--------------------------------------------------

-- Fetched the details of Active Employee"s
select count(attrition) from hr1 where attrition ="no";

 ----------------------------- KPI 1 ---------------------------------------

# 1. Average Attrition rate for all Departments 

select * from hr1;
select Department,count(attrition) `Number of Attrition` from hr1
where attrition = 'yes'
group by Department;

select department, concat(format(count(attrition)/(select count(employeenumber) from hr1)*100,2),'%')  as attrtion_rate
from hr1
where attrition = "yes"
group by department;

 ---------------------------------- KPI 2  --------------------------------------------

# 2. Average Hourly rate of Male Research Scientist

 select Gender, round(avg(HourlyRate),2) `Avg Hourly Rate` from hr1
 where gender = 'male' and jobrole = 'research scientist';
 
  ------------------------------ KPI 3 ----------------------------------------------


# 3. Attrition rate Vs Monthly income stats

create view Attrition_employeeincome as
select h1.department,
round(count(h1.attrition)/(select count(h1.employeenumber) from hr1 h1)*100,2) `Attrtion rate`,
round(avg(h2.MonthlyIncome),2) average_income from hr1 h1 join hr2 h2
on h1.EmployeeNumber = h2.`employee id`
where attrition = 'Yes'
group by h1.department;

select * from attrition_employeeincome;

 ------------------------------------ KPI 4 ----------------------------------------------

# 4. Average working years for each Department

select h1.department,Round(avg(h2.totalworkingyears),0) as Avg_workhrs from hr1 h1
join hr2 h2 on h1.employeenumber = h2.`Employee ID`
group by h1.department;

--------------------------------------------- KPI 5 --------------------------------------------

# 5. Job Role Vs Work life balance

select * from hr2;
select h1.jobrole,h2.worklifebalance, count(h2.worklifebalance) Employee_count
from hr1 h1 join hr2 h2
on h1.employeenumber = h2.`Employee ID`
group by h1.jobrole,h2.worklifebalance
order by h1.jobrole;

 call get_count('Research sciencist','2',@Ecount);
 select @Ecount;

 --------------------------------------------- KPI 6-------------------------------------------

# 6. Attrition rate Vs Year since last promotion relation

select * from  hr2;

select count(h1.attrition) Attrition_count, h2.`YearsSinceLastPromotion`
from hr1 h1 join hr2 h2 on h1.employeenumber = h2.`employee id`
where h1.attrition = 'Yes'
group by`YearsSinceLastPromotion` 
order by `YearsSinceLastPromotion`;
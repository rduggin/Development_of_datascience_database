-- I like to work in Texas, what are the companies that are offering data science jobs in Texas?
select distinct c.name from companies as c 
inner join jobpostings as jp on c.companyID = jp.companyID 
where jp.jobLocation like "%TX"
-- What are skills required to work as a Data Scientist at Adobe?
select s.* from skillsets as s 
inner join jobpostings as jp on s.skillsetID = jp.skillsetID 
inner join jobtitles as jt on jp.jobID = jt.jobID 
inner join companies as c on jp.companyID = c.companyID 
where c.name = "Adobe" and jt.jobSimpleform = "Data Scientist" limit 1
-- Is it better to work for start-ups or well-established companies?
-- 3a 
select avg(employerRating) as employee_rating from jobpostings as jp 
inner join companies as c on jp.companyID = c.companyID 
Where c.AgeinYears < 5
-- 3b
select avg(employerRating) as employee_rating from jobpostings as jp 
inner join companies as c on jp.companyID = c.companyID 
Where c.AgeinYears >= 5
-- Which companies are paying more for data science role like relatively newer companies or older companies?
-- 4a
select avg(jp.salary_avg) from jobpostings as jp 
inner join companies as c on jp.companyID = c.companyID 
where c.AgeinYears < 5
-- 4b
select avg(jp.salary_avg) from jobpostings as jp 
inner join companies as c on jp.companyID = c.companyID 
where c.AgeinYears >= 5
-- What top 3 required skills to work as data scientist in the US?
select sum(ss.python),sum(ss.apache_spark),sum(ss.aws),sum(ss.excel),
sum(ss.sql),sum(ss.sas), sum(ss.keras),sum(ss.pytorch),sum(ss.scikit_learn),sum(ss.tensorflow),
sum(ss.hadoop),sum(ss.tableau),sum(ss.powerBI),sum(ss.apache_flink),sum(ss.mongoDB) from skillsets as ss 
inner join jobpostings as jp on ss.skillsetID = jp.skillsetID 
inner join jobtitles as jt on jp.jobID = jt.jobID 
where jt.jobSimpleform = "Data Scientist"
-- Which state pays higher salaries for Data Engineer?
select jp.jobLocation, avg(jp.salary_avg) as avg_salary from jobpostings as jp 
inner join jobtitles as jt on jp.jobID = jt.jobID 
group by jp.jobLocation order by avg_salary desc
-- Which place has more Data Analyst jobs with average salary greater than 75000?
select jp.jobLocation, count(jp.jobpostingID) as no_of_DA_jobs from jobpostings as jp 
inner join jobtitles as jt on jp.jobID = jt.jobID 
where jt.jobsimpleform = "Data Analyst" group by jp.jobLocation 
order by no_of_DA_jobs desc
-- Name the company that is offering the greater number of data science jobs?
select c.name, count(jp.jobID) as no_of_jobs from companies as c 
inner join jobpostings as jp on c.companyID = jp.companyID 
group by c.name order by no_of_jobs desc;
-- List the companies that are offering Data Scientist, Data Analyst and Data Engineer jobs?
(select distinct c.name from companies as c 
inner join jobpostings as jp on c.companyID = jp.companyID 
inner join jobtitles as jt on jp.jobID = jt.jobID 
where jt.jobSimpleform = 'Data Scientist') intersect 
(select distinct c.name from companies as c 
inner join jobpostings as jp on c.companyID = jp.companyID 
inner join jobtitles as jt on jp.jobID = jt.jobID 
where jt.jobSimpleform = 'Data Analyst') intersect 
(select distinct c.name from companies as c 
inner join jobpostings as jp on c.companyID = jp.companyID 
inner join jobtitles as jt on jp.jobID = jt.jobID 
where jt.jobSimpleform = 'Data Engineer')
-- I want to become a ML Engineer and want the list of companies that are paying more than 150000 for ML Engineers?
select distinct c.name from companies as c
inner join jobpostings as jp on c.companyID = jp.companyID 
inner join jobtitles as jt on jp.jobID =jt.jobID 
where jt.jobSimpleform = 'ML Engineer' and jp.salary_avg > 150000

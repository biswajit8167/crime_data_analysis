create database crime;
use crime;
select * from crime_data;
---1.	Case Disposition:--
----o	How many cases were marked as "CLOSED" vs. "OPEN"?--
select  disposition,count(*)  as total_cases from crime_data
GROUP BY disposition
order by total_cases;

----o	What percentage of cases involved an "ARRESTED" offender?--
select count(offenderstatus)*100/count(*) as percentage_of_arerested_case from crime_data;

---.2.	Crime Categorization:----

----o	What are the most common crime categories in the dataset?---
select category, count(*) as most_common_case
from crime_data
group by category
order by most_common_case desc;

---o	How many crimes were fatal vs. non-fatal for each crime category?--
 select victim_fatal_status, count(*) as total_victim_status
 from crime_data
 group by victim_fatal_status
 order by total_victim_status desc;
 
 ---.3.	Demographic Insights:---
 
 ----o	What is the average age of offenders and victims by race and gender?---
 
 select round(avg(offender_age), 0) as avg_offender_age,
 offender_race,
 offender_gender
 from crime_data
 group by offender_race,offender_gender
 order by avg_offender_age; 
 
 select round(avg(victim_age),0) as avg_victim_age ,
 victim_race,
 victim_gender
 from crime_data
 group by victim_race,victim_gender
 order by avg_victim_age;
 
 
 ---o	Which offender race and gender combination is most common for each crime category?--
 
 select category, offender_race, offender_gender, count(*) as total_crime
 from crime_data
 group by category,offender_race,offender_gender
 order by total_crime desc;
 
 ---4.	Victim and Offender Analysis:---
 
 --o	What is the ratio of male to female victims for each crime type?--
 select category,
 sum(case when victim_gender='MALE' then 1  else 0 end) as male_victims,
 sum(case when victim_gender='FEMALE' then 1 else 0 end) as female_victims,
 concat( sum(case when victim_gender= 'MALE' then 1 else 0 end), ':', sum(case when victim_gender='FEMALE' then 1 else 0 end) )as MALE_TO_FEMALE_RATIO
 from crime_data
 group by category;
 
 ---o	How does victim fatality vary across different races and age groups?----
 
 
 select victim_race, 
 victim_fatal_status,
case when victim_age < 18 then 'under 18'
     when victim_age between 18 and 35 then '18-35'
     when victim_age between 36 and 60 then '36-60'
     else  'above 60'
     end as age_group,
     count(*) as total_cases
from crime_data
group  by victim_race, 
 victim_fatal_status,
case when victim_age < 18 then 'under 18'
     when victim_age between 18 and 35 then '18-35'
     when victim_age between 36 and 60 then '36-60'
     else  'above 60'
     end 
order by total_cases, age_group,victim_race;

----5.	Report Analysis:---

----o	What is the distribution of report types for each crime category?----
select category, report_type, count(*) as distribution_of_report
from crime_data
group by category,report_type
order by distribution_of_report desc;

---o	How many supplemental reports were submitted compared to initial reports?---
 select  report_type, count(*) as total_reports
 from crime_data
 group by report_type
 order by total_reports;

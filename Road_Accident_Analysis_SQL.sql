SELECT * FROM road_accident_db.road_accident_data;

describe road_accident_data;

select * from road_accident_data;
alter table road_accident_data
rename column year to year;

-- total CY Casualties 
select year,sum(Number_of_Casualties) as CY_Casualties
	   from road_accident_data
       group by year
       order by year desc limit 1;
       
-- YoY casulaties
alter table road_accident_data
rename column ï»¿Accident_Index to Accident_Index;

select year, sum(Number_of_Casualties)as Total_Casulaties,
			 (sum(Number_of_Casualties)- lag(sum(Number_of_Casualties),1) over(order by year))/
             lag(sum(Number_of_Casualties),1) over(order by year) * 100 as YoY_Casulaties
             from road_accident_data
             group by year;
             
             
-- Total CY Accidents
select * from road_accident_data;

select year,count(Accident_Index)as CY_Accidents
			from road_accident_data
            group by year
            order by year desc limit 1;
            
-- YoY Accidents

select year, count(Accident_Index) as Total_Accidents,
			 (count(Accident_Index)-lag(count(Accident_Index),1) over(order by year))/
             lag(count(Accident_Index),1) over(order by year) * 100 as YoY_Casulaties
             from road_accident_data
             group by year;
             
-- Total Fatal CY Casulaties

select year,sum(Number_of_Casualties) as CY_Fatal_Casualties
	   from road_accident_data
       where Accident_Severity ="Fatal"
       group by year
       order by year desc limit 1;

-- YoY Fatal CY Casulaties

select year,sum(Number_of_Casualties) as Total_Fatal_Casulaties,
		 (sum(Number_of_Casualties)- lag(sum(Number_of_Casualties),1) over(order by year))/
         lag(sum(Number_of_Casualties),1) over(order by year) * 100 as YoY_Fatal_Casulaties
         from road_accident_data
          where Accident_Severity ="Fatal"
          group by year;
          
-- Total Serious Casulaties

select year,sum(Number_of_Casualties) as CY_Serious_Casualties
	   from road_accident_data
       where Accident_Severity ="Serious"
       group by year
       order by year desc limit 1;

-- YoY_Serious_Casualties
select year,sum(Number_of_Casualties) as Total_Serious_Casulaties,
		 (sum(Number_of_Casualties)- lag(sum(Number_of_Casualties),1) over(order by year))/
         lag(sum(Number_of_Casualties),1) over(order by year) * 100 as CY_Serious_Casualties
         from road_accident_data
          where Accident_Severity ="Serious"
          group by year;

-- Total Slight Casulaties
select year,sum(Number_of_Casualties) as CY_Serious_Casualties
	   from road_accident_data
       where Accident_Severity ="Serious"
       group by year
       order by year desc limit 1;
       

-- Monthly Trend of CY Vs PY Casulaties
alter table road_accident_data
rename column `Accident Date` to accident_date;


  
 /*
 ALTER TABLE road_accident_data
MODIFY COLUMN accident_date DATE;	

alter table road_accident_data
add column new_accident_date date;

select * from road_accident_data;

UPDATE road_accident_data
SET new_accident_date = STR_TO_DATE(accident_date, '%Y-%m-%d'); 
describe road_accident_data;

alter table road_accident_data
drop accident_date;

alter table road_accident_data
rename column new_accident_date to accident_date ; */

--
select monthname(accident_date)as 2021_casulaties,sum(Number_of_Casualties ), 2022_year_casulaties from
(select monthname(accident_date)as 2022_year_casulaties from road_accident_data where year=2022)as end from road_accident_data
where year =2021
	   road_accident_data;
       
       
   SELECT 
    MONTHNAME(accident_date) AS month_name,
    SUM(CASE WHEN YEAR(accident_date) = 2021 THEN Number_of_Casualties ELSE 0 END) AS total_2021_casualties,
    SUM(CASE WHEN YEAR(accident_date) = 2022 THEN Number_of_Casualties ELSE 0 END) AS total_2022_casualties
FROM road_accident_data
GROUP BY MONTH(accident_date), MONTHNAME(accident_date)
ORDER BY MONTH(accident_date);


  SELECT 
    MONTHNAME(accident_date) AS month_name,
    SUM(CASE WHEN YEAR(accident_date) = 2021 THEN Number_of_Casualties END) AS total_2021_casualties, -- can't use sum inside case
    SUM(CASE WHEN YEAR(accident_date) = 2022 THEN Number_of_Casualties END) AS total_2022_casualties
FROM road_accident_data
GROUP BY MONTH(accident_date), MONTHNAME(accident_date)
ORDER BY MONTH(accident_date);


--  Giving rank to the highest casulaties in a month
SELECT 
    month_name,
    total_2021_casualties,
    total_2022_casualties,
    RANK() OVER (ORDER BY total_2022_casualties DESC) AS rank_based_on_2022
FROM (
    SELECT 
        MONTHNAME(accident_date) AS month_name,
        SUM(CASE WHEN YEAR(accident_date) = 2021 THEN Number_of_Casualties ELSE 0 END) AS total_2021_casualties,
        SUM(CASE WHEN YEAR(accident_date) = 2022 THEN Number_of_Casualties ELSE 0 END) AS total_2022_casualties
    FROM road_accident_data
    GROUP BY MONTH(accident_date), MONTHNAME(accident_date)
) AS monthly_data;


-- Casulaties by road type

select Road_Type, sum(Number_of_Casualties) as Total_casulaties
				from road_accident_data
				group by road_type;
                
 -- Casulaties by urban/rural
 select Urban_or_Rural_Area, sum(Number_of_Casualties) 
			from road_accident_data
            group by Urban_or_Rural_Area;

 -- Casulaties by light conditions
 select Light_Conditions, sum(Number_of_Casualties) 
			from road_accident_data
            group by Light_Conditions;
            
-- Casulaties by vehicle type
 select Vehicle_Type, sum(Number_of_Casualties) 
			from road_accident_data
            group by Vehicle_Type;







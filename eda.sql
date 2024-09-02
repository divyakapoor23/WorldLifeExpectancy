-- EDA 
USE World_Life_Expectancy;

SELECT *
FROM world_life_expectancy
;

SELECT Country, MIN(`Lifeexpectancy`), MAX(`Lifeexpectancy`),
ROUND(MAX(`Lifeexpectancy`) - MIN(`Lifeexpectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country 
HAVING MIN(`Lifeexpectancy`) <> 0
AND MAX(`Lifeexpectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC
;

SELECT Year, ROUND(AVG(Lifeexpectancy),2)
FROM world_life_expectancy
WHERE lifeexpectancy <> 0
GROUP BY Year 
ORDER BY YEAR 
;

SELECT country, ROUND(AVG(lifeexpectancy),1) AS life_exp, ROUND(AVG(GDP), 2) AS GDP
FROM world_life_expectancy
GROUP BY country
HAVING life_exp > 0
AND GDP > 0
ORDER BY GDP DESC
;

SELECT 
SUM(CASE 
	WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN Lifeexpectancy  ELSE NULL END) High_GDP_lifexpectancy,
SUM(CASE  WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN Lifeexpectancy  ELSE NULL END) Low_GDP_lifexpectancy
FROM world_life_expectancy
;

SELECT Status, ROUND(AVG(Lifeexpectancy), 1)
FROM world_life_expectancy
GROUP BY Status
;


SELECT Status, COUNT(DISTINCT Country)
FROM world_life_expectancy
GROUP BY Status
;


SELECT country, ROUND(AVG(lifeexpectancy),1) AS life_exp, ROUND(AVG(BMI), 1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING life_exp > 0
AND BMI > 0
ORDER BY BMI ASC
;

SELECT Country, Year, Lifeexpectancy, AdultMortality,
SUM(AdultMortality) OVER(PARTITION BY Country ORDER BY Year)
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;


SELECT *
FROM world_life_expectancy
;

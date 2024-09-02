## DATA CLEANING PROCESS

USE World_Life_Expectancy;
-- RENAME Table worldlifexpectancy TO world_life_expectancy;

SELECT *
FROM world_life_expectancy;

SELECT country, Year, CONCAT(country, Year), COUNT(CONCAT(country, YEAR))
FROM world_life_expectancy
GROUP BY country, Year, CONCAT(country, Year)
HAVING COUNT(CONCAT(country, Year)) > 1
;

SELECT *
FROM(
	SELECT Row_ID,
	CONCAT(country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(country, Year) 
		ORDER BY CONCAT(country, Year)) AS Row_Num
	FROM world_life_expectancy
    ) AS row_table
WHERE Row_Num > 1
;
-- 1251, 2264, 2929 deleting
DELETE FROM world_life_expectancy
WHERE
	ROW_ID IN(
    SELECT Row_ID
	FROM(
		SELECT Row_ID,
		CONCAT(country, Year),
		ROW_NUMBER() OVER(PARTITION BY CONCAT(country, Year) 
		ORDER BY CONCAT(country, Year)) AS Row_Num
		FROM world_life_expectancy
    ) AS row_table
WHERE Row_Num > 1
)
;

SELECT *
FROM world_life_expectancy
WHERE Status = ''
;
    
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> ''
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;
 
 
-- does not work
UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE country IN (SELECT DISTINCT(country)
	FROM world_life_expectancy
	WHERE Status = 'Developing'
)
;

-- Working query
-- keeping the country same and checking the status of t1 if its blank 
-- and making sure t2 is not blank and its devloping to change the status 
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country 
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing'
;

SELECT *
FROM world_life_expectancy
WHERE Status IS NULL
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country 
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed'
;


SELECT *
FROM world_life_expectancy
WHERE Lifeexpectancy = ''
;

SELECT t1.country, t1.Year, t1.`Lifeexpectancy`, 
t2.country, t2.Year, t2.`Lifeexpectancy`,
t3.country, t3.Year, t3.`Lifeexpectancy`,
ROUND((t2.`Lifeexpectancy` + t3.`Lifeexpectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country 
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country 
    AND t1.Year = t3.Year + 1
WHERE t1.`Lifeexpectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country 
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country 
    AND t1.Year = t3.Year + 1
SET t1.`Lifeexpectancy` = ROUND((t2.`Lifeexpectancy` + t3.`Lifeexpectancy`)/2,1)
WHERE t1.`Lifeexpectancy` = ''
;
SELECT *
FROM world_life_expectancy
;
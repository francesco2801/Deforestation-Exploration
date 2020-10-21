-- Tab. 3.3
 
WITH tab_forest_2016 AS
 
(
SELECT country_name country_name_2016,
       (SUM(forest_area_sqkm)) / SUM(total_area_sq_mi * 2.59 / 100) forest_area_2016
  
  FROM forestation
 
 WHERE year = '2016'    
 GROUP BY 1
 ORDER BY 2 DESC
)
 
       
SELECT Quartile,
       COUNT(country_name_2016)
FROM
 
(
SELECT country_name_2016,
       forest_area_2016,
       CASE WHEN forest_area_2016 <= 25 THEN 'Q1'
       WHEN forest_area_2016 <= 50 THEN 'Q2'
       WHEN forest_area_2016 <= 75 THEN 'Q3'
  ELSE 'Q4'
   END AS Quartile
 
  FROM tab_forest_2016
 
 WHERE forest_area_2016 IS NOT NULL
 ORDER BY 3
) tab
        
 GROUP BY 1;

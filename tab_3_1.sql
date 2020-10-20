-- Tab. 3.1
 
WITH tab_forest_1990 AS
 
(
SELECT country_name country_name_1990, 
       region region_name_1990,
       SUM(forest_area_sqkm) forest_area_1990,
       SUM(total_area_sq_mi * 2.59) land_area_1990
  
  FROM forestation
 
 WHERE year = '1990'  AND country_name <> 'World'
 GROUP BY 1, 2
 ORDER BY 2 DESC
),
 
tab_forest_2016 AS
 
(
SELECT country_name country_name_2016, 
       region region_name_2016,
       SUM(forest_area_sqkm) forest_area_2016,
       SUM(total_area_sq_mi * 2.59) land_area_2016
 
  FROM forestation
 
 WHERE year = '2016'    
 GROUP BY 1, 2
 ORDER BY 2 DESC
)
        
        
SELECT country_name_2016,
       region_name_2016,
       land_area_1990,
       land_area_2016,
       forest_area_1990,       
       forest_area_2016,
       CASE WHEN forest_change_1990_2016 > 0 THEN 'increasing'
            ELSE 'decreasing'
       END AS Trend,
       forest_change_1990_2016
 
  FROM (SELECT country_name_2016,
               region_name_2016,
               land_area_1990,
               land_area_2016,
               forest_area_1990,
               forest_area_2016,                 
               ROUND((forest_area_2016 - forest_area_1990)::DECIMAL, 2) AS forest_change_1990_2016
         
          FROM tab_forest_1990
          JOIN tab_forest_2016
            ON country_name_1990 = country_name_2016) t1
 
 WHERE forest_change_1990_2016 IS NOT NULL 
 ORDER BY forest_change_1990_2016 ASC
 LIMIT 5;

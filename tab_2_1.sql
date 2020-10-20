-- Tab 2.1
 
WITH tab_forest_1990 AS
 
(
SELECT region region_name_1990, 
       ROUND( ((SUM(forest_area_sqkm)) / SUM(total_area_sq_mi * 2.59 / 100))::DECIMAL, 2) forest_area_sqkm_1990
 
  FROM forestation         
 
 WHERE year = '1990'
 GROUP BY 1
 ORDER BY 2 DESC
),
 
tab_forest_2016 AS
 
(
SELECT region region_name_2016, 
       ROUND( ((SUM(forest_area_sqkm)) / SUM(total_area_sq_mi * 2.59 / 100))::DECIMAL, 2) forest_area_sqkm_2016
 
  FROM forestation         
 
 WHERE year = '2016'
 GROUP BY 1
 ORDER BY 2 DESC
)
        
        
SELECT *,
       CASE WHEN sott_2016_1990 > 0 THEN 'increasing'
            ELSE 'decreasing'
       END AS Trend,
       sott_2016_1990 
  
  FROM (SELECT region_name_1990,
               forest_area_sqkm_1990,
               forest_area_sqkm_2016,
               forest_area_sqkm_2016 - forest_area_sqkm_1990 AS sott_2016_1990      
          FROM tab_forest_1990
          JOIN tab_forest_2016
            ON region_name_1990 = region_name_2016) t1
 
 ORDER BY sott_2016_1990 DESC;

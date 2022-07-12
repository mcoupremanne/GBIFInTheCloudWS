-- Databricks notebook source
-- MAGIC %md
-- MAGIC **BDS-Ex4:**
-- MAGIC **Aims:**
-- MAGIC * Participants will combine their data cube with countries information
-- MAGIC **Pre-requisites:**
-- MAGIC * BDS-EX3 finished
-- MAGIC **Steps:**
-- MAGIC * Explore your datacube table
-- MAGIC * Explore Countries table
-- MAGIC * Join the two on countryCode, add country’s region and  sub-region
-- MAGIC * Select the class you want to analyze
-- MAGIC * Export your datacube for that class in a CSV file (EX4.csv)
-- MAGIC **Questions:**
-- MAGIC * Which region, subregion have the most records of your class?
-- MAGIC * Which region, subregion have the most specimens of your class?
-- MAGIC * Which region, subregion have the most species of your class?
-- MAGIC 
-- MAGIC ***

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Soluce:**
-- MAGIC 
-- MAGIC *Explore the DataCube:*

-- COMMAND ----------

SELECT * FROM datacube LIMIT(15) ;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC *Explore the countries table:*

-- COMMAND ----------

SELECT * FROM countries ;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Some tips to join the countries table to the DataCube:
-- MAGIC * 'CountryCode' from DataCube and 'alpha-2' from countries table can be linked
-- MAGIC * [Some info on SQL Join queries](https://www.w3schools.com/sql/sql_join.asp)
-- MAGIC * when the naming of a column makes it non-fit to be called with SQL querries, you can use this delimiter on column name :  ``

-- COMMAND ----------

SELECT 
D.*,
c.`sub-region`,
C.`region`
FROM datacube D
LEFT JOIN countries C ON C.`alpha-2` = D.countryCode ;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC *We can use our join query to create an export table for the class Mammalia. Feel free to chose any other class you want to analyse*
-- MAGIC 
-- MAGIC *First we create the view to export*

-- COMMAND ----------

select *

-- COMMAND ----------

select 

-- COMMAND ----------


DROP VIEW IF EXISTS EXPORT;
CREATE VIEW EXPORT AS
SELECT 
D.*,
c.`sub-region`,
c.`alpha-3`,
C.`region`
FROM datacube D
LEFT JOIN countries C ON C.`alpha-2` = D.countryCode
WHERE D.Class='Mammalia';


-- COMMAND ----------

-- MAGIC %md
-- MAGIC *Then we just select the export to download the query result as csv (above the request results)*
-- MAGIC 
-- MAGIC *The export size is limited to 10.000 (you first have to re-run query to overpass the 1000 records limit)* 

-- COMMAND ----------

SELECT * FROM EXPORT; 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC *We can explore our export table further to analyse geographic distribution of (mammals) specimen records*

-- COMMAND ----------

SELECT region, sum(numberRecords)N_records FROM EXPORT GROUP BY region ORDER BY N_records DESC;

-- COMMAND ----------

SELECT `sub-region`, sum(numberRecords)N_records FROM EXPORT GROUP BY `sub-region` ORDER BY N_records DESC;

-- COMMAND ----------

SELECT region, sum(numberSpecimens)N_specimens FROM EXPORT GROUP BY region ORDER BY N_specimens DESC;

-- COMMAND ----------

SELECT `sub-region`, sum(numberSpecimens)N_specimens FROM EXPORT GROUP BY `sub-region` ORDER BY N_specimens DESC;

-- COMMAND ----------

SELECT region, sum(numberSpecies)N_species FROM EXPORT GROUP BY region ORDER BY N_species DESC;

-- COMMAND ----------



-- COMMAND ----------

SELECT `sub-region`, sum(numberSpecies)N_species FROM EXPORT GROUP BY `sub-region` ORDER BY N_species DESC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC *We can now use the exported csv to the exercise 5 in [RawGraphs](https://sandbox.bebif.be/rg/) for further data exploration and visualization*
-- MAGIC 
-- MAGIC *You can also use results display within Databricks to draw graphs, maps and better show the trends of your data ! see below*

-- COMMAND ----------

select * from export ;

-- COMMAND ----------

select * from export;

-- COMMAND ----------

select * from export;

-- COMMAND ----------

Select * from countries  C where C.`alpha-2` in (select distinct(countrycode) from occurrence_20220601);

-- COMMAND ----------

Select distinct(countrycode) from occurrence_20220601 where countrycode not in (select C.`alpha-2`not from countries C);

-- COMMAND ----------

--create database max ;
create table max.occurrence_20220601 as select * from default.occurrence_20220601;

-- COMMAND ----------

select count(*) from max.occurrence_20220601;

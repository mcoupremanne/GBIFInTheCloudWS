-- Databricks notebook source
-- MAGIC %md
-- MAGIC **BDS-Ex3**
-- MAGIC **Aims:**
-- MAGIC * Participants will create a data cube with 3 dimensions : taxonomy, geography and time.
-- MAGIC **Pre-requisites:**
-- MAGIC * BDS-EX2 finished
-- MAGIC **Steps:**
-- MAGIC 
-- MAGIC *Create a DataCube view based on:*
-- MAGIC * Taxonomy by class
-- MAGIC * Geography by countryCode
-- MAGIC * Time by decade
-- MAGIC 
-- MAGIC *In addition to these fields, each cell of your cube will contain:*
-- MAGIC * Number of records (count(*))
-- MAGIC * Number of specimens (sum of ‘individual_count’)
-- MAGIC * Number of species (distinct (species_key))
-- MAGIC 
-- MAGIC **Questions:**
-- MAGIC 
-- MAGIC *Inspect three cells of your data cube:*
-- MAGIC * A (Aves, Australia, 1920s)
-- MAGIC * B (Insecta, Australia, 1900s)
-- MAGIC * C (Insecta, Australia, 1950s)
-- MAGIC 
-- MAGIC *For each cell, answer the following questions:*
-- MAGIC 
-- MAGIC * How many records do you have in these cells?
-- MAGIC * How many specimens do you have in these cells?
-- MAGIC * How many species do you have in these cells?
-- MAGIC 
-- MAGIC ***

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Soluce:**
-- MAGIC 
-- MAGIC *Creating the DataCube:*
-- MAGIC 
-- MAGIC [see SQL functions in Databricks](https://docs.databricks.com/sql/language-manual/sql-ref-functions-builtin.html)

-- COMMAND ----------

DROP VIEW IF EXISTS DATACUBE;

CREATE VIEW DATACUBE AS 
SELECT class, 
       countryCode, 
       10*floor(year/10) AS decade,   
       count(*) AS numberRecords, 
       sum(individualCount) AS numberSpecimens, 
       count(DISTINCT speciesKey) AS numberSpecies 
  FROM Cleaned_Specimen_Records specimens 
  WHERE individualCount IS NOT null AND speciesKey IS NOT null 
  GROUP BY class, countryCode, decade
  ORDER BY class, countryCode, decade
  ;
  


-- COMMAND ----------

-- MAGIC %md
-- MAGIC *Exploring the datacube:*
-- MAGIC 
-- MAGIC *The datacube countains less detail but is usefull to better explore some trends over the data!*

-- COMMAND ----------

SELECT * FROM datacube WHERE countryCode='AU' AND class='Aves' AND decade=1920;

-- COMMAND ----------

SELECT * FROM datacube WHERE countryCode='AU' AND class='Insecta' AND decade=1900;

-- COMMAND ----------

SELECT * FROM datacube WHERE countryCode='AU'  AND class='Insecta' AND decade=1950;

-- Databricks notebook source
-- MAGIC %md
-- MAGIC **BDS-Ex1**
-- MAGIC 
-- MAGIC **Aims:**
-- MAGIC Participants will get acquainted with Databricks
-- MAGIC 
-- MAGIC **Pre-requisites:**
-- MAGIC * BD-EX0 finished
-- MAGIC * Have access to Databricks
-- MAGIC 
-- MAGIC **Steps:**
-- MAGIC * Create a new notebook
-- MAGIC * Discover the default.occurrence_20220601 table
-- MAGIC * Create a view on preserved specimen records with year, class and countryCode not null
-- MAGIC * Explore further the data
-- MAGIC 
-- MAGIC **Questions:**
-- MAGIC * How many occurrences are recorded in the GBIF snapshot? 2.203.539.570
-- MAGIC * How many specimens are recorded? 205.009.567
-- MAGIC * How many specimens are recorded with year, class and countryCode? 151.748.571
-- MAGIC * What other records would you exclude from your analysis? Why? See individualCount, decimalLat/long, speciesKey, issues…
-- MAGIC 
-- MAGIC ***

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **SOLUCE:**
-- MAGIC 
-- MAGIC *The table can be found in the left menu/data/default/tables*
-- MAGIC 
-- MAGIC *we can access to occurrence_20220601 table with SQL queries:*

-- COMMAND ----------


SELECT COUNT(*) FROM occurrence_20220601 ;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC *We can see that our extract countains more than **2 billions records**, almost all records available on [GBIF](https://www.gbif.org/).*
-- MAGIC 
-- MAGIC 
-- MAGIC *We now look at the Darwin Core term '[basisOfRecord'](https://dwc.tdwg.org/terms/#dwc:basisOfRecord) and how it can be used to filter specimen records:*

-- COMMAND ----------

SELECT basisOfRecord, COUNT(*) FROM occurrence_20220601 GROUP BY basisOfRecord ;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC *We create a view on preserved specimen records where year, class and countryCode are not null :*

-- COMMAND ----------

DROP VIEW IF EXISTS  Cleaned_Specimen_Records;
CREATE VIEW Cleaned_Specimen_Records
AS
  SELECT *
  FROM  occurrence_20220601 
  WHERE basisOfRecord = 'PRESERVED_SPECIMEN'
  AND   year IS NOT NULL AND class IS NOT NULL AND CountryCode IS NOT NULL;
  

-- COMMAND ----------

SELECT COUNT(*) FROM Cleaned_Specimen_Records;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC *"What other records would you exclude from your analysis? Why?"*
-- MAGIC 
-- MAGIC Let's have a look at:
-- MAGIC * [number of individuals](https://dwc.tdwg.org/list/#dwc_individualCount)
-- MAGIC * longitude, latitude
-- MAGIC * [speciesKey](https://discourse.gbif.org/t/understanding-gbif-taxonomic-keys-usagekey-taxonkey-specieskey/3045)
-- MAGIC * [issues and flags](https://data-blog.gbif.org/post/issues-and-flags/) 

-- COMMAND ----------

SELECT * FROM Cleaned_Specimen_Records WHERE individualCount > 1000000;

-- COMMAND ----------

SELECT COUNT(*) FROM Cleaned_Specimen_Records WHERE decimalLongitude IS NULL OR decimalLatitude IS NULL;

-- COMMAND ----------

SELECT COUNT(*) FROM Cleaned_Specimen_Records WHERE decimalLongitude =0 OR decimalLatitude =0;

-- COMMAND ----------

SELECT COUNT(*) FROM Cleaned_Specimen_Records WHERE speciesKey is null;

-- COMMAND ----------

SELECT issue, count(*)N  FROM Cleaned_Specimen_Records GROUP BY issue ORDER BY N DESC ;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC All these fields can be used to filter the data

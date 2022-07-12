-- Databricks notebook source
-- MAGIC %md
-- MAGIC **BDS-Ex2**
-- MAGIC **Aims:**
-- MAGIC * Participants to discover GBIF mediated specimens data.
-- MAGIC **Pre-requisites:**
-- MAGIC * BD-EX1 finished
-- MAGIC * Have access to Datrabricks
-- MAGIC **Steps:**
-- MAGIC * Create a table on specimen records with year, class and countryCode not null
-- MAGIC * Subset some columns 'gbifID', 'individualCount','countryCode', 'year', 'class', 'speciesKey' 
-- MAGIC * Drop rows with null values
-- MAGIC * Describe the resulting data
-- MAGIC **Questions:**
-- MAGIC * Which ‘class’ has more specimens records?
-- MAGIC * Which ‘class’ has more distinct species of specimens?
-- MAGIC * Which ‘class’ has more individual specimens?
-- MAGIC 
-- MAGIC ***

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Soluce:**
-- MAGIC 
-- MAGIC *Create a view on specimen records with year, class and countryCode not null*

-- COMMAND ----------

DROP VIEW IF EXISTS Cleaned_Specimen_Records; 
CREATE VIEW Cleaned_Specimen_Records
AS
  SELECT *
  FROM  occurrence_20220601 
  WHERE basisOfRecord = 'PRESERVED_SPECIMEN'
  AND   year IS NOT NULL AND class IS NOT NULL AND CountryCode IS NOT NULL;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Now we:
-- MAGIC * *Create a new view  keeping only the information we want to use*
-- MAGIC * *Exclude records showing null values for these columns*
-- MAGIC * *Count the number of records left*

-- COMMAND ----------

DROP VIEW IF EXISTS Cleaned_Specimen_Records; 
CREATE VIEW Cleaned_Specimen_Records
AS SELECT gbifID, individualCount,countryCode, year, class, speciesKey
  FROM  occurrence_20220601 
  WHERE basisOfRecord = 'PRESERVED_SPECIMEN'
  AND   gbifID          IS NOT NULL 
  AND   individualCount IS NOT NULL 
  AND   countryCode     IS NOT NULL
  AND   year            IS NOT NULL 
  AND   class           IS NOT NULL 
  AND   speciesKey      IS NOT NULL
        ;




-- COMMAND ----------

SELECT COUNT(*) FROM Cleaned_Specimen_Records;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC *The same query structure can be used to make some comparisons between the different taxonomic classes in the resulting data:*

-- COMMAND ----------

SELECT class,COUNT(*) N FROM Cleaned_Specimen_Records GROUP BY class ORDER BY N DESC ;


-- COMMAND ----------

SELECT class,COUNT(DISTINCT speciesKey) N_species FROM SUBSET GROUP BY class ORDER BY N_species DESC ;

-- COMMAND ----------

SELECT class,SUM(individualCount) N_specimens FROM SUBSET GROUP BY class ORDER BY N_specimens DESC ;

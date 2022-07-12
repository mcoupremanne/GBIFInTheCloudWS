
**BDS-Ex1**

**Aims:**
Participants will get acquainted with Databricks

**Pre-requisites:**
* BD-EX0 finished
* Have access to Databricks

**Steps:**
* Create a new notebook
* Discover the default.occurrence_20220601 table
* Create a view on preserved specimen records with year, class and countryCode not null
* Explore further the data

**Questions:**
* How many occurrences are recorded in the GBIF snapshot? 2.203.539.570
* How many specimens are recorded? 205.009.567
* How many specimens are recorded with year, class and countryCode? 151.748.571
* What other records would you exclude from your analysis? Why? See individualCount, decimalLat/long, speciesKey, issues…

***

**BDS-Ex2**
**Aims:**
* Participants to discover GBIF mediated specimens data.
**Pre-requisites:**
* BD-EX1 finished
* Have access to Datrabricks
**Steps:**
* Create a table on specimen records with year, class and countryCode not null
* Subset some columns 'gbifID', 'individualCount','countryCode', 'year', 'class', 'speciesKey'
* Drop rows with null values
* Describe the resulting data
**Questions:**
* Which ‘class’ has more specimens records?
* Which ‘class’ has more distinct species of specimens?
* Which ‘class’ has more individual specimens?

***

**BDS-Ex3**
**Aims:**
* Participants will create a data cube with 3 dimensions : taxonomy, geography and time.
**Pre-requisites:**
* BDS-EX2 finished
**Steps:**

*Create a DataCube view based on:*
* Taxonomy by class
* Geography by countryCode
* Time by decade

*In addition to these fields, each cell of your cube will contain:*
* Number of records (count(*))
* Number of specimens (sum of ‘individual_count’)
* Number of species (distinct (species_key))

**Questions:**

*Inspect three cells of your data cube:*
* A (Aves, Australia, 1920s)
* B (Insecta, Australia, 1900s)
* C (Insecta, Australia, 1950s)

*For each cell, answer the following questions:*

* How many records do you have in these cells?
* How many specimens do you have in these cells?
* How many species do you have in these cells?

***


**BDS-Ex4:**
**Aims:**
* Participants will combine their data cube with countries information
**Pre-requisites:**
* BDS-EX3 finished
**Steps:**
* Explore your datacube table
* Explore Countries table
* Join the two on countryCode, add country’s region and  sub-region
* Select the class you want to analyze
* Export your datacube for that class in a CSV file (EX4.csv)
**Questions:**
* Which region, subregion have the most records of your class?
* Which region, subregion have the most specimens of your class?
* Which region, subregion have the most species of your class?

***

**SDS-Ex1**

**Aims:**

Participants will get acquainted with Jupyter Lab, Python and Pandas data frame.

**Pre-requisites:**
SD-EX0 finished
Have access to JupyterLab
Create your own Jupyter notebook

**Steps:**
* Load CSV into a panda dataframe
* Subset some columns 'gbifID', 'individualCount','countryCode', 'year', 'class', 'speciesKey'
* Drop rows with null values
* Save this dataframe in a EX1.CSV file
* Describe the resulting data

**Questions:**
* How many rows do you have in the original file?
* How many rows remain after dropping null values?

***

**SDS-Ex2**

**Aims:**

Participants will do simple manipulations on Pandas data frame.

**Pre-requisites:**
* SDS-EX1 finished
* Steps
* Load EX1.csv into panda dataframe
* Group data by class
* Group data by countryCode
* Group data by year
* Create a dataframe with all Belgian Insecta specimens, discard the others
* Describe the resulting data

**Questions:**
* How many rows do you have for class Insecta?
* How many rows do you have for Belgium?
* How many rows do you have for 1961?
* How many Belgian Insecta in the 1960’s rows do you have?

***

**SDS-Ex3:**

**Aims:**

Participants will create a data cube with 3 dimensions : taxonomy, geography and time.

**Pre-requisites:**
* SDS-EX2 finished

**Steps:**
* Load EX1.csv into panda dataframe
* Add a ‘decade’ field
* Count the number of records, numbers of specimens and species for this cell : Insecta, Belgium, 1960s
* *Create a 3D data frame based on:*
  * Taxonomy by class
  * Geography by countryCode
  * Time by decade

* *In addition to these fields, each cell of your cube will contain:*
  * Number of records (count(*))
  * Number of specimens (sum of ‘individual_count’)
  * Number of species (distinct (species_key))
* Save your data cube in EX3.csv file

**Questions:**
* Inspect three cells of your data cube:
  * A (Aves, Belgium, 1950s)
  * B (Insecta, Belgium, 1900s)
  * C (Insecta, Belgium, 1950s)

* For each cell, answer the following questions:
  * How many records do you have in these cells?
  * How many specimens do you have in these cells?
  * How many species do you have in these cells?

***

**SDS-Ex4**

**Aims:**

Participants will combine their data cube with countries information
**Pre-requisites:**
* SDS-EX3 finished

**Steps:**
* Load your Data Cube(EX3.csv) in a dataframe
* Filter the Insecta cells, discard the others
* Load Countries.csv in a dataframe
* Join the two dataframe on countryCode add country region and  sub-region
* Save your results in EX4.csv file

**Question:**
* How many non empty cells do you have?

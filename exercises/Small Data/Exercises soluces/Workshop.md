# EBRII Platform Workshop

## SD-Ex0

The file was downloaded as explained and copied in the directory of this notebook file. The given name to the download is `data.csv`.

Before starting to play with the data, some general imports and configuration are made :


```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

plt.style.use('seaborn')
```

## SDP-Ex1

Let's first open the file and get a general idea of its content :


```python
df = pd.read_csv("C:/Users/46123/Desktop/Workshop/inputs/gbif_col.csv", sep='\t')

print(df.shape)
df.info(memory_usage='deep')
```

    (28739, 50)
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 28739 entries, 0 to 28738
    Data columns (total 50 columns):
     #   Column                            Non-Null Count  Dtype  
    ---  ------                            --------------  -----  
     0   gbifID                            28739 non-null  int64  
     1   datasetKey                        28739 non-null  object 
     2   occurrenceID                      28739 non-null  object 
     3   kingdom                           28739 non-null  object 
     4   phylum                            27063 non-null  object 
     5   class                             27040 non-null  object 
     6   order                             26892 non-null  object 
     7   family                            26886 non-null  object 
     8   genus                             27206 non-null  object 
     9   species                           23332 non-null  object 
     10  infraspecificEpithet              1047 non-null   object 
     11  taxonRank                         28739 non-null  object 
     12  scientificName                    28739 non-null  object 
     13  verbatimScientificName            28693 non-null  object 
     14  verbatimScientificNameAuthorship  9353 non-null   object 
     15  countryCode                       19846 non-null  object 
     16  locality                          18229 non-null  object 
     17  stateProvince                     0 non-null      float64
     18  occurrenceStatus                  28739 non-null  object 
     19  individualCount                   27313 non-null  float64
     20  publishingOrgKey                  28739 non-null  object 
     21  decimalLatitude                   11766 non-null  float64
     22  decimalLongitude                  11766 non-null  float64
     23  coordinateUncertaintyInMeters     0 non-null      float64
     24  coordinatePrecision               0 non-null      float64
     25  elevation                         0 non-null      float64
     26  elevationAccuracy                 0 non-null      float64
     27  depth                             0 non-null      float64
     28  depthAccuracy                     0 non-null      float64
     29  eventDate                         18742 non-null  object 
     30  day                               16838 non-null  float64
     31  month                             16923 non-null  float64
     32  year                              18742 non-null  float64
     33  taxonKey                          28739 non-null  int64  
     34  speciesKey                        23332 non-null  float64
     35  basisOfRecord                     28739 non-null  object 
     36  institutionCode                   28739 non-null  object 
     37  collectionCode                    27583 non-null  object 
     38  catalogNumber                     28739 non-null  int64  
     39  recordNumber                      0 non-null      float64
     40  identifiedBy                      1122 non-null   object 
     41  dateIdentified                    0 non-null      float64
     42  license                           28739 non-null  object 
     43  rightsHolder                      28739 non-null  object 
     44  recordedBy                        5286 non-null   object 
     45  typeStatus                        997 non-null    object 
     46  establishmentMeans                0 non-null      float64
     47  lastInterpreted                   28739 non-null  object 
     48  mediaType                         0 non-null      float64
     49  issue                             28739 non-null  object 
    dtypes: float64(18), int64(3), object(29)
    memory usage: 57.5 MB
    

Let's then re-read the file with only the needed columns in order to limit memory usage :


```python
df = pd.read_csv( 'C:/Users/46123/Desktop/Workshop/inputs/gbif_col.csv',
    sep='\t',
    usecols=['gbifID', 'individualCount', 'countryCode', 'year', 'class', 'speciesKey'],
    dtype={'gbifID': 'Int64', 'individualCount': 'Int16', 'year': 'Int16', 'speciesKey': 'Int64'})

print(df.shape)
df.info(memory_usage='deep')
```

    (28739, 6)
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 28739 entries, 0 to 28738
    Data columns (total 6 columns):
     #   Column           Non-Null Count  Dtype 
    ---  ------           --------------  ----- 
     0   gbifID           28739 non-null  Int64 
     1   class            27040 non-null  object
     2   countryCode      19846 non-null  object
     3   individualCount  27313 non-null  Int16 
     4   year             18742 non-null  Int16 
     5   speciesKey       23332 non-null  Int64 
    dtypes: Int16(2), Int64(2), object(2)
    memory usage: 3.8 MB
    

Let's filter the data and drop lines where some data is missing, then save the result in a new .CSV file :


```python
df = df.dropna()
df.to_csv('ex1.csv')

print(df.shape)
```

    (13561, 6)
    

## SDP-Ex2

`GROUP BY` are not really needed to answer to the questions in the end of the steps. Here's however an example to group elements by class and count how many rows we have per class :


```python
df.groupby("class").size()
```




    class
    Actinopterygii          147
    Agaricomycetes            5
    Amphibia                 14
    Arachnida                 4
    Asteroidea               10
    Aves                     60
    Cephalaspidomorphi        1
    Cephalopoda               1
    Chromadorea             484
    Echinoidea                1
    Elasmobranchii           10
    Enoplea                  47
    Gastropoda                6
    Holothuroidea             2
    Insecta               12641
    Liliopsida                2
    Magnoliopsida             1
    Malacostraca              1
    Mammalia                 88
    Pilidiophora              2
    Polychaeta                1
    Reptilia                 33
    dtype: int64



How many rows have class Insecta ?


```python
df[df["class"] == "Insecta"].shape[0]
```




    12641



Another `GROUP BY` country code :


```python
df.groupby("countryCode").agg(count = ("gbifID", "size"))
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>count</th>
    </tr>
    <tr>
      <th>countryCode</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>AQ</th>
      <td>6</td>
    </tr>
    <tr>
      <th>AR</th>
      <td>13</td>
    </tr>
    <tr>
      <th>AT</th>
      <td>2</td>
    </tr>
    <tr>
      <th>AU</th>
      <td>48</td>
    </tr>
    <tr>
      <th>BE</th>
      <td>12747</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
    </tr>
    <tr>
      <th>SR</th>
      <td>1</td>
    </tr>
    <tr>
      <th>TR</th>
      <td>10</td>
    </tr>
    <tr>
      <th>US</th>
      <td>37</td>
    </tr>
    <tr>
      <th>VE</th>
      <td>2</td>
    </tr>
    <tr>
      <th>ZA</th>
      <td>12</td>
    </tr>
  </tbody>
</table>
<p>63 rows × 1 columns</p>
</div>



How many rows for Belgium ?


```python
df[df["countryCode"] == "BE"]["gbifID"].count()
```




    12747



Then a `GROUP BY ... HAVING` year :


```python
df.groupby("year").filter(lambda group: len(group) > 30).groupby("year").size()
```




    year
    1892    216
    1893    133
    1900    278
    1901    299
    1902    376
           ... 
    1981     84
    1982    107
    1983     62
    1984    278
    2000     38
    Length: 73, dtype: int64



How many rows for 1961 ?


```python
df[df["year"] == 1961]["gbifID"].count()
```




    57



Let's create the Belgian Insecta dataframe :


```python
belgian_insectas = df[(df["class"] == "Insecta") & (df["countryCode"] == "BE")]
```

How many Belgian Insecta specimens in the 1960's


```python
belgian_insectas[(belgian_insectas["year"] >= 1960) & (belgian_insectas["year"] <= 1969)]["gbifID"].count()
```




    110



## SDP-Ex3

Cubes aren't really existing in `Pandas`. At a certain time, there was a `Panel` object which was deprecated then removed, the developers guiding the users to using the `MultiIndex` object. Another possibility would be to use the `Xarray` library but this not `Pandas` anymore...

Here, a `MultiIndex` will be used to create a `DataFrame` indexed by `class`, `countryCode` and `decade`.

First let's add a new `decade` column to our `DataFrame` :


```python
df["decade"] = 10 * (df["year"] // 10)

df.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>gbifID</th>
      <th>class</th>
      <th>countryCode</th>
      <th>individualCount</th>
      <th>year</th>
      <th>speciesKey</th>
      <th>decade</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>8</th>
      <td>1440056918</td>
      <td>Cephalopoda</td>
      <td>PH</td>
      <td>1</td>
      <td>1988</td>
      <td>2289202</td>
      <td>1980</td>
    </tr>
    <tr>
      <th>13</th>
      <td>1440056913</td>
      <td>Pilidiophora</td>
      <td>FR</td>
      <td>1</td>
      <td>1960</td>
      <td>2508430</td>
      <td>1960</td>
    </tr>
    <tr>
      <th>16</th>
      <td>1440056910</td>
      <td>Polychaeta</td>
      <td>BE</td>
      <td>1</td>
      <td>1955</td>
      <td>5198833</td>
      <td>1950</td>
    </tr>
    <tr>
      <th>24</th>
      <td>1440056902</td>
      <td>Gastropoda</td>
      <td>PH</td>
      <td>1</td>
      <td>2005</td>
      <td>4361138</td>
      <td>2000</td>
    </tr>
    <tr>
      <th>37</th>
      <td>1440056889</td>
      <td>Gastropoda</td>
      <td>AU</td>
      <td>7</td>
      <td>1967</td>
      <td>2293072</td>
      <td>1960</td>
    </tr>
    <tr>
      <th>47</th>
      <td>1440056879</td>
      <td>Pilidiophora</td>
      <td>FR</td>
      <td>1</td>
      <td>1961</td>
      <td>2508484</td>
      <td>1960</td>
    </tr>
    <tr>
      <th>49</th>
      <td>1440056877</td>
      <td>Gastropoda</td>
      <td>AU</td>
      <td>7</td>
      <td>1967</td>
      <td>2293072</td>
      <td>1960</td>
    </tr>
    <tr>
      <th>314</th>
      <td>1440056612</td>
      <td>Echinoidea</td>
      <td>AU</td>
      <td>3</td>
      <td>1967</td>
      <td>7687837</td>
      <td>1960</td>
    </tr>
    <tr>
      <th>363</th>
      <td>1440056563</td>
      <td>Holothuroidea</td>
      <td>AU</td>
      <td>2</td>
      <td>1967</td>
      <td>2279167</td>
      <td>1960</td>
    </tr>
    <tr>
      <th>458</th>
      <td>1440056468</td>
      <td>Asteroidea</td>
      <td>AU</td>
      <td>1</td>
      <td>1967</td>
      <td>2271208</td>
      <td>1960</td>
    </tr>
  </tbody>
</table>
</div>



Now we can construct our cube as described and save it in a new file :


```python
cube = df.groupby(["class", "countryCode", "decade"]).agg(
    records=("gbifID", "size"),
    specimens=("individualCount", "sum"),
    species=("speciesKey", "nunique")
)

cube.head(10)

cube.to_csv("ex3.csv")
```

Let's verify that our query from the previous exercise giving the number of Insecta in Belgium in the 1960s is the same in our cube :


```python
cube.loc[('Insecta', 'BE', 1960),:]
```




    records      110
    specimens    126
    species       92
    Name: (Insecta, BE, 1960), dtype: Int64



Content of cell (Aves, Belgium, 1920s) ?

Making the full request tells us that this cell is empty. We can verify this by indexing Aves from Belgium down here :


```python
cube.loc[("Aves", "BE")]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>records</th>
      <th>specimens</th>
      <th>species</th>
    </tr>
    <tr>
      <th>decade</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1850</th>
      <td>8</td>
      <td>8</td>
      <td>6</td>
    </tr>
    <tr>
      <th>1860</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1870</th>
      <td>5</td>
      <td>5</td>
      <td>5</td>
    </tr>
    <tr>
      <th>1880</th>
      <td>18</td>
      <td>18</td>
      <td>13</td>
    </tr>
    <tr>
      <th>1890</th>
      <td>11</td>
      <td>12</td>
      <td>10</td>
    </tr>
    <tr>
      <th>1900</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1910</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1950</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1980</th>
      <td>4</td>
      <td>4</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1990</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



Content of cell (Insecta, Belgium, 1900s) ?


```python
cube.loc[('Insecta', 'BE', 1900),:]
```




    records      1966
    specimens    2039
    species       851
    Name: (Insecta, BE, 1900), dtype: Int64



Content of cell (Insecta, Belgium, 1950s) ?


```python
cube.loc[('Insecta', 'BE', 1950),:]
```




    records      1183
    specimens    1353
    species       789
    Name: (Insecta, BE, 1950), dtype: Int64



## SDP-Ex4

First, let's open the `countries.csv` file and get a general idea of its content :


```python
countries = pd.read_csv('C:/Users/46123/Desktop/Workshop/inputs/countries.csv')

print(countries.shape)
countries.info(memory_usage='deep')
```

    (249, 11)
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 249 entries, 0 to 248
    Data columns (total 11 columns):
     #   Column                    Non-Null Count  Dtype  
    ---  ------                    --------------  -----  
     0   name                      249 non-null    object 
     1   alpha-2                   248 non-null    object 
     2   alpha-3                   249 non-null    object 
     3   country-code              249 non-null    int64  
     4   iso_3166-2                249 non-null    object 
     5   region                    249 non-null    object 
     6   sub-region                249 non-null    object 
     7   intermediate-region       108 non-null    object 
     8   region-code               248 non-null    float64
     9   sub-region-code           248 non-null    float64
     10  intermediate-region-code  107 non-null    float64
    dtypes: float64(3), int64(1), object(7)
    memory usage: 116.0 KB
    

Let's then re-read the file with only the needed columns in order to limit memory usage :


```python
countries = pd.read_csv( \
    'C:/Users/46123/Desktop/Workshop/inputs/countries.csv',
    usecols=['alpha-2', 'region', 'sub-region'],
)

print(countries.shape)
countries.info(memory_usage='deep')
```

    (249, 3)
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 249 entries, 0 to 248
    Data columns (total 3 columns):
     #   Column      Non-Null Count  Dtype 
    ---  ------      --------------  ----- 
     0   alpha-2     248 non-null    object
     1   region      249 non-null    object
     2   sub-region  249 non-null    object
    dtypes: object(3)
    memory usage: 48.1 KB
    

Let's rename `alpha-2` as `countryCode` to match our cube and set this column as the index :


```python
countries.rename(columns={"alpha-2": "countryCode"}, inplace=True)
countries.set_index("countryCode", inplace=True)

countries.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>region</th>
      <th>sub-region</th>
    </tr>
    <tr>
      <th>countryCode</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>AF</th>
      <td>Asia</td>
      <td>Southern Asia</td>
    </tr>
    <tr>
      <th>AX</th>
      <td>Europe</td>
      <td>Northern Europe</td>
    </tr>
    <tr>
      <th>AL</th>
      <td>Europe</td>
      <td>Southern Europe</td>
    </tr>
    <tr>
      <th>DZ</th>
      <td>Africa</td>
      <td>Northern Africa</td>
    </tr>
    <tr>
      <th>AS</th>
      <td>Oceania</td>
      <td>Polynesia</td>
    </tr>
    <tr>
      <th>AD</th>
      <td>Europe</td>
      <td>Southern Europe</td>
    </tr>
    <tr>
      <th>AO</th>
      <td>Africa</td>
      <td>Sub-Saharan Africa</td>
    </tr>
    <tr>
      <th>AI</th>
      <td>Americas</td>
      <td>Latin America and the Caribbean</td>
    </tr>
    <tr>
      <th>AQ</th>
      <td>Antarctica</td>
      <td>Antarctica</td>
    </tr>
    <tr>
      <th>AG</th>
      <td>Americas</td>
      <td>Latin America and the Caribbean</td>
    </tr>
  </tbody>
</table>
</div>



Now we can join the two `DataFrames` and add the columns needed for the queries :


```python
augmentedCube = cube.join(countries)

augmentedCube.head(20)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th></th>
      <th>records</th>
      <th>specimens</th>
      <th>species</th>
      <th>region</th>
      <th>sub-region</th>
    </tr>
    <tr>
      <th>class</th>
      <th>countryCode</th>
      <th>decade</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="20" valign="top">Actinopterygii</th>
      <th>AQ</th>
      <th>1990</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>Antarctica</td>
      <td>Antarctica</td>
    </tr>
    <tr>
      <th>AU</th>
      <th>1960</th>
      <td>5</td>
      <td>10</td>
      <td>5</td>
      <td>Oceania</td>
      <td>Australia and New Zealand</td>
    </tr>
    <tr>
      <th rowspan="13" valign="top">BE</th>
      <th>1870</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1880</th>
      <td>9</td>
      <td>9</td>
      <td>6</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1890</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1900</th>
      <td>20</td>
      <td>21</td>
      <td>18</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1910</th>
      <td>5</td>
      <td>5</td>
      <td>5</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1920</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1930</th>
      <td>4</td>
      <td>12</td>
      <td>4</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1940</th>
      <td>20</td>
      <td>29</td>
      <td>18</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1950</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1960</th>
      <td>20</td>
      <td>46</td>
      <td>19</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1980</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>1990</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>2000</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>CO</th>
      <th>1930</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Americas</td>
      <td>Latin America and the Caribbean</td>
    </tr>
    <tr>
      <th>FR</th>
      <th>1960</th>
      <td>17</td>
      <td>63</td>
      <td>14</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>GA</th>
      <th>2000</th>
      <td>30</td>
      <td>44</td>
      <td>30</td>
      <td>Africa</td>
      <td>Sub-Saharan Africa</td>
    </tr>
    <tr>
      <th>HN</th>
      <th>1930</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Americas</td>
      <td>Latin America and the Caribbean</td>
    </tr>
    <tr>
      <th>LU</th>
      <th>1920</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
  </tbody>
</table>
</div>



Let's save this result that will be used for plotting later :


```python
augmentedCube.to_csv("ex4.csv")
```

How many specimens for Insecta in Nothern Europe in the 1950s ?

It seems Northern Europe only has data in GB in the 1960s...


```python
augmentedCube.loc[pd.IndexSlice['Insecta', :, 1960]]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th></th>
      <th>records</th>
      <th>specimens</th>
      <th>species</th>
      <th>region</th>
      <th>sub-region</th>
    </tr>
    <tr>
      <th>class</th>
      <th>countryCode</th>
      <th>decade</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">Insecta</th>
      <th>BE</th>
      <th>1960</th>
      <td>110</td>
      <td>126</td>
      <td>92</td>
      <td>Europe</td>
      <td>Western Europe</td>
    </tr>
    <tr>
      <th>GB</th>
      <th>1960</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Europe</td>
      <td>Northern Europe</td>
    </tr>
  </tbody>
</table>
</div>




```python
augmentedInsecta = augmentedCube.loc['Insecta', :]

augmentedInsecta[augmentedInsecta["sub-region"] == "Northern Europe"]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>records</th>
      <th>specimens</th>
      <th>species</th>
      <th>region</th>
      <th>sub-region</th>
    </tr>
    <tr>
      <th>countryCode</th>
      <th>decade</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>GB</th>
      <th>1960</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>Europe</td>
      <td>Northern Europe</td>
    </tr>
  </tbody>
</table>
</div>




```python

```

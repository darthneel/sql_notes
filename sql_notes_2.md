Starter Code Link - http://bit.ly/1Jnmh2R

#SQL Bootcamp Demo and Exercise Solutions


##Demo - `users.sql`


* Get all user data
```sql
  SELECT * FROM  users;
  ```
* Order by last name
```sql
  SELECT * FROM users ORDER BY last_name;
  ```
* WHERE: Get only male users
```sql
  SELECT * FROM users WHERE gender = 'male';
  ```
* IN: Get from massachusetts or montana
```sql
  SELECT * FROM users WHERE state IN ('montana','massachusetts')
  ```
* LIKE: Get from either dakotas
```sql
  SELECT * FROM users WHERE name LIKE '%dakota';
  ```
* AND: Get men from albany
```sql
  SELECT * FROM users WHERE gender = "male" AND city = "albany";
  ```
* OR: Get californians, and anyone last named 'Diaz'
```sql
  SELECT * FROM users WHERE state = "california" OR last_name = "diaz";
  ```
* **Functions**
  * Get LENGTH of passwords
    * Get users with passwords less than 10 characters
    ```sql
    SELECT * FROM users WHERE LENGTH(password) < 10;
    ```
  * CONCAT: Full name as one field, full address as other field
  ```sql
  SELECT CONCAT_WS(' ', first_name, last_name) FROM users;
  ```
* DISTINCT
  * first names
  ```sql
  SELECT DISTINCT first_name FROM users;
  ```
* LIMIT
  * Get 10 users
  ```sql
  SELECT DISTINCT first_name FROM users LIMIT 10;
  ```


##Exercise -`president.sql`

* List all columns for all presidents
```sql
SELECT * FROM presidents;
```
* List only last names and birth dates for all presidents in order from oldest
```sql
SELECT last_name, birth FROM presidents ORDER BY birth DESC;
```
* List only presidents who died before Jan 1, 1900
```sql
SELECT * FROM presidents WHERE DEATH < '1900-01-01';
```
* List the unique first names of presidents
```sql
SELECT DISTINCT first_name FROM presidents;
```
* List the 10 youngest presidents
```sql
SELECT * FROM presidents ORDER BY birth DESC LIMIT 10;
```

##Demo - `band.sql`

* SELECT WHERE id = foreign_key
```sql
SELECT * FROM sales WHERE album_id = 3;
```
* INNER JOIN
  * Get album sales including album name
  ```sql
  SELECT * FROM sales
  INNER JOIN albums
    ON albums.id=sales.album_id
  WHERE albums.id = sales.album_id;
  ```
* Multiple joins
  * Get song and album name for a single album
    ```sql
  SELECT albums.title, songs.title FROM albums
  INNER JOIN tracklists
    ON albums.id=tracklists.album_id
  INNER JOIN songs
    ON tracklists.song_id = songs.id
  WHERE albums.id = 2;
  ```
  * Order by track position
  ```sql
  SELECT albums.title, songs.title FROM albums
  INNER JOIN tracklists
    ON albums.id=tracklists.album_id
  INNER JOIN songs
    ON tracklists.song_id = songs.id
  WHERE albums.id = 1
  ORDER BY tracklists.position;
  ```
  * Multiple order by
    * Order by album and then track position
    ```sql
      SELECT albums.title, songs.title, tracklists.position FROM albums
      INNER JOIN tracklists
        ON albums.id=tracklists.album_id
      INNER JOIN songs
        ON tracklists.song_id = songs.id
      ORDER BY albums.title, tracklists.position;
      ```

##Exercise - `world.sql`


* Find all languages spoken in Indonesia
```sql
SELECT CountryLanguage.language FROM CountryLanguage
INNER JOIN Country
 ON Country.code = CountryLanguage.CountryCode
WHERE Country.name = "Indonesia";
```
* See a list of North American countries and their accompanying languages
```sql
SELECT Country.name, CountryLanguage.language FROM CountryLanguage
INNER JOIN Country
 ON Country.code = CountryLanguage.CountryCode
WHERE Country.continent = "North America"
```
* See a list of cities in China
```sql
SELECT City.name FROM City
INNER JOIN Country
  ON Country.code = City.CountryCode
WHERE Country.name = "China";
```
* See unique languages spoken in all Federal Republics
```sql
SELECT DISTINCT CountryLanguage.language FROM CountryLanguage
INNER JOIN Country
  ON CountryLanguage.CountryCode = Country.code
WHERE Country.GovernmentForm = "Federal Republic";
```

##Demo - `band.sql`


* COUNT
  * Total number of albums
  ```sql
  SELECT COUNT(*) FROM albums;
  ```
* COUNT with condition
  * Total number of quarters with greater than 180000
  ```sql
  SELECT COUNT(*) FROM sales WHERE gross > 180000;
  ```
* COUNT GROUP BY how many male and female users
  ```sql
  SELECT test.users.gender, COUNT(gender) FROM test.users GROUP BY test.users.gender;
  ```
* SUM sales per album
```sql
SELECT *, SUM(gross) FROM sales GROUP BY album_id;
```
```sql
SELECT albums.title, SUM(gross) FROM sales
INNER JOIN albums
 ON sales.album_id = albums.id
GROUP BY albums.title;
```
* AVG sales per quarter
```sql
SELECT *, AVG(sales.gross) FROM sales GROUP BY sales.quarter;
```
* Songs with more than 4 instruments
```sql
SELECT title, COUNT(*) AS total_instruments FROM songs
INNER JOIN instruments
  ON songs.id = instruments.song_id GROUP BY songs.id
HAVING total_instruments > 4;
```

#Extra Practice

`presidents.sql`

* Total number of presidents coming from each state, ordered

* Number of presidents born after 1800.


`countries.sql`

* Find the top 5 countries in terms of language spoken

* Calculate the average GNP grouped by continent

* Top 5 countries in terms of average city size

* Find the names of all cities in countries with a head of state named John

`flights.sql`

* Count the number of airports

* Count the number of airlines that fly out of JFK
  * Note - This will require a [subquery](https://sqlschool.modeanalytics.com/advanced/subqueries/)



#Solutions for Extra Practice

##Solution - `presidents.sql`


* Total number of presidents coming from each state, ordered
```sql
SELECT state, COUNT(state) AS states_count FROM presidents
GROUP BY state
ORDER BY states_count DESC;
```
* Number of presidents born after 1800.
```sql
SELECT COUNT(*) FROM presidents WHERE birth > '1801-01-01';
```

##Solution - `countries.sql`

* Find the top 5 countries in terms of language spoken
```sql
SELECT Country.name, COUNT(*) AS lang_count FROM Country
INNER JOIN CountryLanguage
  ON Country.code= CountryLanguage.CountryCode
GROUP BY Country.name
ORDER BY lang_count DESC LIMIT 5;
```
* Calculate the average GDP grouped by continent
```sql
SELECT continent, AVG(GNP) FROM Country GROUP BY continent;
```
* Top 5 countries in terms of average city size
```sql
SELECT Country.name, AVG(City.population) AS avg_pop FROM Country
INNER JOIN City
  ON Country.code = City.CountryCode
GROUP BY Country.name
ORDER BY avg_pop DESC LIMIT 5;
```
* Find the names of all cities in countries with a head of state named John
```sql
SELECT City.Name, Country.Name FROM Country
INNER JOIN City
  ON City.CountryCode = Country.Code
WHERE Country.HeadOfState LIKE "John%";
```

##Solution - `flights.sql`

* Count the number of airports
```sql
SELECT COUNT(*) FROM airports;
```

* Count the number of airlines that fly out of JFK
```sql
SELECT COUNT(*) FROM(
SELECT DISTINCT airlines.name FROM airports
INNER JOIN routes
  ON airports.id = routes.origin_id
INNER JOIN airlines
  ON airlines.id = routes.dest_id
WHERE airports.iata_faa = "JFK"
) AS x;
```
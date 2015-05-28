Starter Code Link - http://bit.ly/1Jnmh2R

## Introductions & motivations [15 min]

Hello - everyone say name and what they do.

**Why SQL**?

Why use a database?
  * data integrity
  * recalling data

Why not a sheet of paper and filing cabinets?

Quick example:
  * Attendance sheet for this class.
  * What might be the issues in storing and working with data in this way?

Why not Excel?
  * speed (larger datasets)
  * stability (data integrity)

History Lesson
  * SQL invented by IBM in the early 70's
  * Response to important paper on relational data
  * Databases use complex relational algebra and calculus
  * We needed something human readable, so SQL was created

## Concepts & overview [30 min.]

* SQL as a standard; most prevalent RDBMSes
* Applications versus database
* Server, client, localhost, networking
* Anatomy of a database
  * Multiple schemas with multipel tables in each schema
  * Example with Petco schema, dogs and owners table
* What is relational data?
  * VERY brief explanation of WHY we want dogs and dog owners to be related. (Do not yet discuss how to do it)
* Goal of SQL is to easily allow us to recall and work with subsets of data

## Up and Running [15 mins]

**I Do**

Show them around the MYSQLWorkbench.

Set default database.

Import data - `users.sql`

Let's draw out ERD for users.

## Listing Stuff (90 mins)

**Skills**:

* SELECT, WHERE, ORDER BY, DISTINCT, LIMIT

**Demo Dataset**:

* `users.sql`

**I Do**
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
    * Get users with passwords longer than 8 characters
    ```sql
    SELECT * FROM users WHERE LENGTH(password) > 10;
    ```
  * CONCAT: Full name as one field
  ```sql
  SELECT CONCAT_WS(' ', first_name, last_name) FROM users;
  ```
* DISTINCT
  * first names
  ```sql
  SELECT DISTINCT first_name FROM users;
  ```
* COUNT
  * number of users
  ```sql
  SELECT COUNT(*) FROM users;
  ```
  * We can also combine functions 
    * how many states are users from
    ```sql
    SELECT COUNT(DISTINCT state) FROM users;
    ```
* LIMIT
  * Get 10 users
  ```sql
  SELECT DISTINCT first_name FROM users LIMIT 10;
  ```

### Exercise [20/30 mins]

Dataset: `president.sql`

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

## Relating Information (90 mins)

**Skills**:

* INNER JOIN
* ERD

**Demo Dataset**

* `band.sql`

**I Do**

Data modeling

one -> many:
  * company, employees

many -> many:
  * zipcar - customers, cars, rentals

Create new SCHEMA
Import band.sql

Draw ERD of band database - albums, songs, sales.

* SELECT WHERE id = foreign_key
```sql
SELECT * FROM sales WHERE album_id = 3;
```
* INNER JOIN
  * Get album sales including album name
  ```sql
  SELECT * FROM sales
  INNER JOIN albums
    ON albums.id=sales.album_id;
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

### Exercise <!-- [20 mins] -->

`world.sql`


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

## Summarizing Information

**Skills**:

* COUNT, GROUP BY, SUM, AVG, HAVING

**Dataset**:

`band.sql`

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
```
SELECT albums.title, CONCAT('$', FORMAT(SUM(gross), 0)) AS total_sales FROM sales
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

### Exercise

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

`countries.sql`

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

## Lab - Flights

Import `flights.sql`

* Count the number of airports
  *
  ```sql
  SELECT COUNT(*) FROM airports;
  ```
* Count the number of airlines that fly out of JFK
  *
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
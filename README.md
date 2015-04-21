## Introductions & motivations [15 min]

Hello - everyone say name and what they do.

**Why SQL**?

Why not filing cabinets?

Why not Excel?
  * speed (larger datasets)
  * stability (data integrity)

## Concepts & overview [30 min.]

* SQL as a standard; most prevalent RDBMSes
* Applications versus database
  * SQL, because it is text based, can inte
* Server, client, localhost, networking
* Anatomy of a database
  * Data model - tables are entities - example for dogs

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
* Get just their address fields
* Order by last name
* WHERE
  * =: Get only male users
  * IN: Get from massachusetts or montana
  * LIKE: Get from either dakotas
  * AND: Get men from albany
  * OR: Get californians, and anyone last named 'Diaz'
* Functions
  * Get LENGTH of passwords
    * >: Get users with passwords longer than 8 characters (needs HAVING)
  * CONCAT: Full name as one field, full address as other field
* DISTINCT
  * first names
* LIMIT
  Get 10 users

### Exercise [20/30 mins]

Dataset: `president.sql`

* list all columns for all presidents
* list only last names and birth dates for all presidents in order from oldest
* list only presidents who died before Jan 1, 1900
* list the unique first names of presidents
* list the 10 youngest presidents

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
  - sales for a particular album
* INNER JOIN
  * Get album sales including album name
* Multiple joins
  * Get song and album name for a single album
  * Order by track position
  * Multiple order by
    * Order by album and then track position

### Exercise <!-- [20 mins] -->

`world.sql`

* Find all languages spoken in Indonesia
* See a list of North American countries and their accompanying languages
* See a list of cities in China
* See unique languages spoken in all Federal Republics

```sql
SELECT * FROM CountryLanguage WHERE CountryLanguage.CountryCode = '';

SELECT * FROM Country INNER JOIN CountryLanguage on Country.Code = CountryLanguage.CountryCode WHERE Continent = 'North America'; 

SELECT DISTINCT CountryLanguage.Language FROM Country INNER JOIN CountryLanguage on Country.Code = CountryLanguage.CountryCode WHERE GovernmentForm = 'Federal Republic'; 
```

## Summarizing Information

**Skills**:

* COUNT, GROUP BY, SUM, AVG, HAVING

**Dataset**:

`band.sql`

* COUNT
  * total number of albums
* COUNT with condition
  * total number of quarters with greater than 180000
* COUNT GROUP BY how many male and female users
* SUM sales per album
  * `select *, sum(gross) from sales group by album_id;`
* AVG sales per quarter
  * `select *, avg(gross) from sales group by quarter;`
* Songs with more than 4 instruments
* most profitable market each year
  * `select *, sum(gross) from sales group by market, year;`

### Exercise

`presidents.sql`

* Total number of presidents coming from each state, ordered
* Number of presidents born after 1800.

`countries.sql`

* Find the top 5 countries in terms of language spoken
* Calculate the average GDP grouped by continent
* Top 5 countries in terms of average city size
* Find the names of all cities in countries with a head of state named John

```sql
SELECT Country.Name, COUNT(*) FROM Country INNER JOIN CountryLanguage on Country.Code = CountryLanguage.CountryCode GROUP BY Country.Code; 
```

## Lab - Flights

Import `flights.sql`

* Count the number of airports
* Count the number of airlines that fly out of JFK
* Count the number of routes per airline out of JFK

## Import CSV (30 mins)

Simple dataset - create table...

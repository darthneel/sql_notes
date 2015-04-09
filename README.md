### Import Data

**I Do**

Show them around the MYSQLWorkbench. Let's draw out ERD for users.

Data modeling?

Basic query `SELECT`

* `users.sql`

## Listing Information

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
  * >: Get users with passwords longer than 8 characters
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

## Relating Information

**Skills**:

* INNER JOIN
* ERD

**Demo Dataset**

* `band.sql`

**I Do**

Draw ERD of band database.

* INNER JOIN
  * Get album sales including album name
* Multiple joins
  * Get song and album name for a single album
  * Order by track position
  * Multiple order by
    * Order by album and then track position

**You Do**

Get a list of song names, member names, and instruments on the song

## Summarizing Information

**Skills**:

* COUNT, GROUP BY, SUM, AVG, HAVING, MIN

**Dataset**:

`band.sql`

* COUNT
  * total number of albums
* COUNT with condition
  * total number of markets
* COUNT GROUP BY how many male and female users
* SUM sales per album
* AVG sales per quarter
* HAVING sales greater than 100k
* album with MIN global sales each year
* most profitable market each year

### Exercise

`presidents.sql`

* Total number of presidents coming from each state, ordered by state

## Import CSV

Simple dataset - create table...

## Lab - Flights

Import `flights.sql`

* Count the number of airports
* Count the number of airlines that fly out of JFK
* Count the number of routes per airline out of JFK



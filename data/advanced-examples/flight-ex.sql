-- select CONCAT(first_name, ' ', last_name) as name, abs(datediff(birth, death)) / 365 as age from presidents order by age desc;

-- select distinct country from airports;

-- airports with the most international flights
-- select origin.name, count(*) as international_flights from airports as origin
-- inner join routes on routes.origin_id = origin.id
-- inner join airports as destination on destination.id = routes.dest_id
-- where origin.country = 'United States' and destination.country <> 'United States'
-- group by origin.name
-- order by international_flights desc;

-- airline hubs

select name, (MAX(total_flights) / SUM(total_flights)) as percentage_airline, MAX(total_flights), airline_code from 
(

select airports.name, routes.airline_code, count(*) as total_flights from airports
inner join routes on airports.id = routes.origin_id
group by airports.name, routes.airline_code
order by total_flights desc

) as x
group by name
having SUM(total_flights) > 100
order by percentage_airline desc
;




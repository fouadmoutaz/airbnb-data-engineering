-- Q.4: Recommendations for Vacationers
-- For a Man with His Wife and 2 Children Looking for a Week Vacation around March 2024:

with AvailableDays as (

  select c.listing_id ,  d.date , ROW_NUMBER() over(partition by c.listing_id order by d.date ) as row_num
  from calendar_Fact c
  join date_Dim d
  on d.date_key = c.date_key
  where d.month = 3 and d.year = 2024 and c.available='t'
),
ConsecutiveDays as(
select 
	listing_id ,
	min(date) as start_date,
	max(date) as end_date,
	count(*) as num_available_days
from AvailableDays 
group by listing_id
)
select top 3 cd.listing_id , name , num_available_days , accommodates,  price
from ConsecutiveDays cd
join listing_Dim l 
on l.listing_id = cd.listing_id
where num_available_days >= 7 and accommodates >= 4 AND name LIKE '%2 bedrooms%4 beds%'
order by price , start_date ,num_available_days desc;




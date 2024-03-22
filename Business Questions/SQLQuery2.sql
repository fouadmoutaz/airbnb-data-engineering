-- Q.1: Cheapest and Most Available Listing in January 2024
select top 1 l.name , min(c.price) as cheapest_price , count(*) as availability  
from listing_Dim l
join calendar_Fact c
on l.listing_id = c.listing_id
join date_Dim d 
on d.date_key = c.date_key
where month = 1 and year = 2024
group by l.name , c.listing_id
order by cheapest_price asc


ALTER TABLE listing_Dim
ALTER COLUMN price FLOAT;

UPDATE listing_Dim
SET price = REPLACE(price, '$', '');







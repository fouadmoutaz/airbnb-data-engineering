-- Q.2: Most Reviewed Listings in November 2023
select r.listing_id , l.name , count(*) as review_count
from review_Fact r
join listing_Dim l 
on r.listing_id  = l.listing_id
join date_Dim d
on d.date_key = r.date_key
where month = 11 and year = 2023
group by r.listing_id , l.name
order by review_count desc;


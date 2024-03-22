-- Q.3: Most Expensive Neighborhood in Barcelona
select l.neighbourhood_group_cleansed , max(c.price) as max_price
from listing_Dim l
join calendar_Fact c 
on l.listing_id = c.listing_id
group by l.neighbourhood_group_cleansed 
order by max_price desc;


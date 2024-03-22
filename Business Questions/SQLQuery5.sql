-- Q5: For a College Student with 4 Other Students Planning to Spend New Year's Eve in Barcelona:

select distinct top 5  l.listing_id , l.name , l.accommodates , c.price
from listing_Dim l
join calendar_Fact c
on l.listing_id = c.listing_id
join date_Dim d
on d.date_key = c.date_key
where c.available ='t' and d.date between '2023-12-30' AND '2024-01-01' 
		and accommodates >= 5 and l.name like '%5 beds%'
order by c.price asc  ;





use mini_project;

-- 1. Melihat pendapatan sewa film
select	film_id, title, category,
		rating, 
		sum(rental_rate) as total_rental_income,
		date(last_update) as last_update
from movie_rental_income
group by 1, 2, 3, 4, 6
order by 5 desc;
		

-- 2. Melihat segmentasi customer
select 	film_id, title, 
		category, rating,
		fullname, rental_frequency,
		sum(amount) as total_amount,
		date(last_update) as last_update 
from customer_segmentation
group by 1, 2, 3, 4, 5, 6, 8
order by 6, 7 desc;


-- 3. Film yang paling sering terlambat dikembalilkan serta jumlah keterlambatannya
select 	id, title, 
		rental_date, 
		count(*) as total_late_return
from rental_film
where rental_return > rental_duration
group by 1, 2, 3
order by 4 desc;











































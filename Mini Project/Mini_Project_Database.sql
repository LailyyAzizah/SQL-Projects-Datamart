
-- MINI PROJECT
use sakila;
-- Buat Datamart (data yang sudah bersih) + ERD nya
-- jangan lupa kolom datenya (tahun, bulan, dan tanggal)

-- Yang dia minta adalah:
-- 1.	Melihat pendapatan sewa(rental rate) dari 
-- 		Judul film
--		Rating film
--		Kategori film

-- Melihat pendapatan sewa dari film
select 	fil.film_id, cat.category_id, 
		fil.title,cat.name as category, fil.rating,
		fil.release_year, fil.rental_rate,
		date(fil.last_update) as last_update
from film fil
left join film_category fc on fc.film_id = fil.film_id 
left join category cat on cat.category_id = fc.category_id;


-- 2.	Melakukan segmentasi customer:
--		Frekuensi Peminjaman
--		Total Biaya Sewa
--		Jenis film yang sering di sewa (kategori film dan rating film)

-- Melakukan segmentasi customer
select	cust.customer_id, 
		fil.film_id,
		fil.title,
		fil.description,
		cat.name as category,
		fil.rating,
		concat(cust.first_name,' ', cust.last_name) as fullname,
		count(r.customer_id) as rental_frequency,
		p.amount as amount,
		date(cust.last_update) as last_update
from customer cust
join payment p on p.customer_id = cust.customer_id 
left join rental r on r.rental_id = p.rental_id  
left join inventory i on i.inventory_id = r.inventory_id 
left join film fil on fil.film_id = i.film_id
left join film_category fc on fc.film_id = fil.film_id 
left join category cat on cat.category_id = fc.category_id 
group by 1, 2, 3, 4, 5, 6, 7, 9, 10;


-- 3.	Melihat informasi keterlambatan sewa seperti:
--		Film yang paling sering terlambat dikembalikan
--		Berapa jumlah keterlambatan dalam periode tertentu
--	Rumus untuk mengecek apakah penyewaan tersebut dinyatakan terlambat adalah
--	Membandingkan rental duration film dan jarak antara tanggal peminjaman dan tanggal kembali


-- Film yang paling sering terlambat dikembalikan dan jumlah keterlambatan
select 	f.film_id as id,
		f.title,
		f.description,
		f.`length`,
		date(r.rental_date) as rental_date,
		f.rental_duration,
		datediff(r.return_date, r.rental_date) as rental_return
from rental r 
left join inventory i on i.inventory_id = r.inventory_id 
left join film f on f.film_id = i.film_id
join payment p on r.rental_id = p.rental_id;


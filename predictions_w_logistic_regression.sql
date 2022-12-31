use sakila;

-- -- -- -- -- which films will be rented next month? -- -- -- -- --


# Getting relevant info from film and rental

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

CREATE OR REPLACE VIEW relevant_info AS
SELECT DISTINCT(A.film_id) AS film_id, A.title, MONTH(C.rental_date) AS month, COUNT(C.rental_id) AS n_rentals,
LAG(COUNT(C.rental_id),1,0) OVER(PARTITION BY A.film_id) AS last_month
FROM film A INNER JOIN inventory B ON A.film_id = B.film_id INNER JOIN rental C ON B.inventory_id = C.inventory_id
WHERE MONTH(C.rental_date) = 2 OR MONTH(C.rental_date) = 8
GROUP BY A.film_id, MONTH(C.rental_date)
ORDER BY A.film_id, MONTH(C.rental_date);

SELECT * FROM relevant_info;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

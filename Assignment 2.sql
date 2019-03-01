/*
 * Assignment 2
 * Dominick Arnaldo
 */
 
 /* #1 */
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) as "TOTAL SPENT"
FROM sakila.customer c
JOIN sakila.payment p
	ON c.customer_id = p.customer_id
    GROUP BY customer_id
	ORDER BY c.last_name;
    
/* #2 */
SELECT DISTINCT a.district, c.city
FROM sakila.address a
JOIN sakila.city c 
	ON a.city_id = c.city_id 
	WHERE a.postal_code IS NULL OR a.postal_code = '';
    
/* #3 */
SELECT title FROM sakila.film WHERE title LIKE '%DOCTOR%' OR title LIKE '%FIRE%';

/* #4 */
SELECT a.actor_id, a.first_name, a.last_name, COUNT(f.film_id) as "NUMBER OF MOVIES"
FROM sakila.actor a 
JOIN sakila.film_actor f
	ON a.actor_id = f.actor_id
    GROUP BY actor_id
    ORDER BY a.last_name;
    
/* #5 */
SELECT c.name, AVG(f.length) as "AVERAGE RUN TIME"
FROM sakila.film f
JOIN sakila.film_category fcat
	ON f.film_id = fcat.film_id
JOIN sakila.category c 
	ON c.category_id = fcat.category_id
    GROUP BY c.category_id
    ORDER BY AVG(f.length);
    
/* #6 */
SELECT DISTINCT s.store_id, SUM(p.amount) as "REVENUE"
FROM sakila.store s 
JOIN sakila.staff st
	ON s.store_id = st.store_id
JOIN sakila.payment p 
	ON p.staff_id = st.staff_id
    GROUP BY s.store_id
    ORDER BY SUM(p.amount) desc;
    
/* #7 */
SELECT c.first_name, c.last_name, c.email, SUM(p.amount) as "TOTAL SPENT"
FROM sakila.customer c
JOIN sakila.address a
	ON c.address_id = a.address_id
JOIN sakila.city ci
	ON a.city_id = ci.city_id
JOIN sakila.country co 
	ON co.country_id = ci.country_id AND co.country = "Canada"
JOIN sakila.payment p 
	ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
    ORDER BY c.last_name;
    
/* #8 */
/*
SELECT customer_id FROM sakila.customer WHERE first_name = "Mathew" AND last_name = "Bolin";
Customer ID: 539
*/
/*
SELECT i.inventory_id
FROM sakila.inventory i 
JOIN sakila.film f 
	ON i.film_id = f.film_id AND f.title = "HUNGER ROOF";
Inventory ID: 2023 - 2026
*/
/*
SELECT staff_id FROM sakila.staff WHERE first_name = "Jon" AND last_name = "Stephens";
Staff ID: 2
*/

start transaction;

INSERT INTO sakila.rental (inventory_id, customer_id, staff_id) VALUES(2023, 539, 2);

/*
SELECT rental_id FROM sakila.rental WHERE inventory_id = 2023 AND customer_id = 539 AND staff_id = 2;
Rental ID: 16059
*/


INSERT INTO sakila.payment (customer_id, staff_id, rental_id, amount) VALUES(539, 2, 16059, 2.99);

commit;


/* #9 */
/*
SELECT customer_id FROM sakila.customer WHERE first_name = "Tracy" AND last_name = "Cole";
Customer ID: 108
*/
/*
SELECT i.inventory_id 
FROM sakila.inventory i 
JOIN sakila.film f
	ON f.film_id = i.film_id AND f.title = "ALI FOREVER";
Inventory ID: 67-70
*/


start transaction;

UPDATE sakila.rental SET return_date = now() WHERE customer_id = 108 AND inventory_id = 70;

commit;


/* #10 */

start transaction;

UPDATE sakila.film
	JOIN sakila.film_category fc
		ON film.film_id = fc.film_id
	JOIN sakila.category c
		ON c.category_id = fc.category_id AND c.name = "ANIMATION"
	SET original_language_id = (SELECT language_id FROM sakila.language WHERE name = "JAPANESE");

commit;

SELECT * FROM sakila.film;
Use sakila;

#1a. Display first and last names of all actors from table actors 
Select first_name, last_name
from actor;
#1b. 
Select 
Concat(first_name," ", last_name) as "Actor Name"
from actor;

#2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name,
# "Joe." What is one query would you use to obtain this information?
Select actor_id, first_name, last_name
from actor
where first_name = "Joe";

#2b. Find all actors whose last name contain the letters GEN:
Select first_name, last_name 
from actor
where last_name 
Like "%GEN%";

#2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
Select first_name, last_name 
from actor
where last_name 
Like "%Li%"
Order By last_name, first_name;

#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
Select country_id, country
from country
Where country
in("Afghanistan", "Bangladesh", "China");

#3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column 
#in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it 
#and VARCHAR are significant).
ALTER TABLE actor
ADD description BLOB;

#3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE actor 
DROP description;

#4a. List the last names of actors, as well as how many actors have that last name.
Select last_name, count(*)
from actor
Group By last_name;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
Select last_name, count(*) as "Count"
from actor
Group By last_name
Having count(*) >1;

#4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
Update actor
Set first_name = 'HARPO'
Where first_name = 'Groucho' 
AND last_name = 'Williams';

#4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! 
#In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
Update actor
Set first_name = 'GROUCHO'
Where first_name = 'HARPO';

#5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
Describe sakila.address;

#6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
Select first_name, last_name, a.address
from staff s
inner join address a
on a.address_id = s.address_id;


#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
Select Concat(first_name,"", s.last_name) As "Name", sum(p.amount) As "Total"
from staff s
inner join payment p
on p.staff_id = s.staff_id
Where p.payment_date Like "2005-08%"
Group by p.staff_id;

#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join. film_id
Select title, Count(actor_id) As "Number of Actors"
from film f
inner join film_actor fa
on fa.film_id = f.film_id
Group by title;


#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
Select title, count(i.film_id) As "Copies Available"
from film f
inner join inventory i 
on i.film_id = f.film_id
Where title Like "Hunchback Impossible"
Group by f.film_id;


#6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
Select first_name, last_name, Sum(p.amount) As "Total Paid"
from customer c
inner join payment p
on p.customer_id = c.customer_id
Group by p.customer_id
Order by last_name;

#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
Select title from film
Where language_id in 
(Select language_id
from language
where name = "English")
And title Like "K%" or title Like "Q%";


#7b. Use subqueries to display all actors who appear in the film Alone Trip.
Select first_name, last_name
from actor
Where actor_id in(
Select actor_id from film_actor
Where film_id in(
Select film_id from film
Where title = "Alone Trip" ));

#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
Select Concat(first_name, " ", last_name) As "Name", email
from customer cu
Inner join address a
on a.address_id = cu.address_id
Inner join city c
on c.city_id = a.city_id
Inner join country co
on co.country_id = c.city_id
Where country = "Canada";

#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
Select title as "Film", category as "Category" 
from film_list 
Where category = "Family";

#7e. Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(rental_id) AS 'Number of Times Rented'
FROM rental r
JOIN inventory i
ON (r.inventory_id = i.inventory_id)
JOIN film f
ON (i.film_id = f.film_id)
GROUP BY f.title
ORDER BY `Number of Times Rented` DESC;

#7f. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(amount) AS 'Business Amount'
FROM payment p
JOIN rental r
ON (p.rental_id = r.rental_id)
JOIN inventory i
ON (i.inventory_id = r.inventory_id)
JOIN store s
ON (s.store_id = i.store_id)
GROUP BY s.store_id; 

#7g. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country 
FROM store s
JOIN address a 
ON (s.address_id = a.address_id)
JOIN city c
ON (c.city_id = a.city_id)
JOIN country co
ON (co.country_id = c.country_id);

#7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT c.name AS 'Genre', SUM(p.amount) AS 'Gross' 
FROM category c
JOIN film_category fc 
ON (c.category_id=fc.category_id)
JOIN inventory i 
ON (fc.film_id=i.film_id)
JOIN rental r 
ON (i.inventory_id=r.inventory_id)
JOIN payment p 
ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;


#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW top_five AS

SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;
#8b. How would you display the view that you created in 8a?
SELECT * FROM top_five;
#8c. You find that you no longer need the view top_five_genres. Write a query to delete it.

Drop View top_five;

# Actifity 2
#Using your gwsis database, develop a stored procedure that will drop an individual student's enrollment from a class. Be sure to refer to the existing stored procedures, enroll_student
#and terminate_all_class_enrollment in the gwsis database for reference.
#The procedure should be called terminate_student_enrollment and should accept the course code, section, student ID, and effective date of the withdrawal as parameters.
Use gwsis;



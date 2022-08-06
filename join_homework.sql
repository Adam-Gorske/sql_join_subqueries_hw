--1. List all customers who live in Texas (use JOINs)
select first_name, last_name, district
from customer
inner join address
on customer.address_id = address.address_id
where district = 'Texas';


--2. Get all payments above $6.99 with the Customer's Full Name
select first_name, last_name, amount
from customer
inner join payment 
on customer.customer_id = payment.customer_id
where amount > 6.99
order by amount desc;


--3. Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 175.00
);


--4. List all customers that live in Nepal (use the city table)

-- Nepal is not a city in city, and this will show that...
select *
from city


-- But to find customer that live in Nepal (if there was a Nepal)...
select first_name, last_name
from customer
where address_id in (
	select address_id 
	from address
	where city_id in(
		select city_id
		from city
		where city = "Nepal"
	)
);


--5. Which staff member had the most transactions
-- Jon Stephens with 7,304 
select first_name, last_name, count(amount)
from staff 
full join payment 
on staff.staff_id = payment.staff_id
group by staff.first_name, staff.last_name
order by count(amount) desc;


--6. How many movies of each rating are there?
select film.rating, count(title)
from film
group by film.rating;


--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99
	group by customer.first_name, customer.last_name, payment.customer_id
	order by count(amount) = 1
);


--8. How many free rentals did our store give away?
-- None
select count(amount)
from payment 
where amount = 0.00;

--But it looks like someone is getting a bunch of money credited to them. Money laundering? Hmmm....
-- Mary Smith has $29,645.60 in credits...
select first_name, last_name, sum(amount)
from payment
full join customer
on payment.customer_id = customer.customer_id
where amount <= 0.00
group by customer.first_name, customer.last_name




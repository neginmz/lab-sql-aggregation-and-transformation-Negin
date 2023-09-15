-- Challenge 1
-- As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

use sakila;
select min(length) as min_duration , max(length) as max_duration from film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
select round(avg(length)/60) as hours,round(avg(length)) as minutes from film;
-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date. 
select max(rental_date) as last_date, min(rental_date) as first_date , DATEDIFF(max(rental_date),min(rental_date)) AS DiffDate from rental; 
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
select *, substr(rental_date,6,2) as rental_month, weekday(rental_date) as rental_weekday,
case 
when weekday(rental_date) = 0 then 'Monday' 
when weekday(rental_date) = 1 then 'Tuesday'
when weekday(rental_date) = 2 then 'Wednesday'
when weekday(rental_date) = 3 then 'Thursday'
when weekday(rental_date) = 4 then 'Friday'
when weekday(rental_date) = 5 then 'Saturday'
when weekday(rental_date) = 6 then 'Sunday'
end as 'weekday description',
case
when weekday(rental_date) = 0 then 'Weekday' 
when weekday(rental_date) = 1 then 'Weekday' 
when weekday(rental_date) = 2 then 'Weekday' 
when weekday(rental_date) = 3 then 'Weekday' 
when weekday(rental_date) = 4 then 'Weekday' 
when weekday(rental_date) = 5 then 'Weekend'
when weekday(rental_date) = 6 then 'weekend'
end as 'Day_Type'
from rental
limit 10;
-- We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
select title, rental_duration from film
where IFNULL(rental_duration, 'Not available');

-- As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. To achieve this, we want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, so that we can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier for us to use the data.
select concat(first_name,' ',last_name,' ', left(email, 3)) from customer
order by last_name Asc;
-- We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(*) from film
where release_year is not null;
-- 1.2 The number of films for each rating.
-- 1.3 The number of films for each rating, and sort the results in descending order of the number of films. This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.
select count(film_id) as film_number, rating from film
group by rating
order by film_number Desc;
-- We need to track the performance of our employees. Using the rental table, determine the number of rentals processed by each employee. This will help us identify our top-performing employees and areas where additional training may be necessary
select count(rental_id) as rental_processed, first_name, last_name from rental
inner join staff on staff.staff_id=rental.staff_id
group by rental.staff_id;
-- Using the film table, determine:
-- 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.
select round(avg(length),2) as film_duration, rating  from film
group by rating
order by film_duration Desc;
-- 3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.
select round(avg(length),2) as film_duration, rating  from film
group by rating
having film_duration/60>2
order by film_duration Desc;
-- Determine which last names are not repeated in the table actor.
select last_name, count(last_name) as number_of_repetition from actor
group by last_name
having number_of_repetition=1;


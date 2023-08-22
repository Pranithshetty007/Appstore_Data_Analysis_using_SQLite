CREATE TABLE apple_discription_combined AS

SELECT * FROM appleStore_description1

Union ALL

SELECT * FROM appleStore_description2

Union ALL

SELECT * FROM appleStore_description3

Union ALL

SELECT * FROM appleStore_description4

*** Exploratory Data Analysis ***

----check the number of unique apps

select count (distinct id) as Uniqueappid
from AppleStore

select count (distinct id) as Uniqueappid
from apple_discription_combined

----check missing values 

select count (*) as Missingvalues
from AppleStore
where track_name is NULL or user_rating is NULL or prime_genre is NULL


select count (*) as Missingvalues
from apple_discription_combined
where app_desc is NULL

---- No of Apps per Genre 

SELECT prime_genre, COUNT(*) as numapps
from AppleStore
GROUP by prime_genre
ORDER by numapps DESC

---- Get an overview of apps rating 

SELECT max(user_rating) as Maxrating,
       min(user_rating) as Minrating,
       avg(user_rating) as Avgrating
From AppleStore

** DATA Analysis **
---- determine whether paid apps have higher rating compared to free apps 

SELECT CASE 
           when price > 0 then "paid"
           else "Free"
           end as App_type,
           avg(user_rating) as Avgrating
from AppleStore
group by App_type

--- Check if app that support more languages have higher rating 

SELECT CASE 
           when lang_num < 10 then "10_languages"
           when lang_num between 10 and 30  then "10_to_30_languages"
           else ">30_languages"
           end as Lang_type,
           avg(user_rating) as Avgrating
from AppleStore
group by Lang_type

------ genre with low ratings 

select prime_genre,
       avg(user_rating) as Avgrating
from AppleStore
group by prime_genre
order by Avgrating ASC
limit 10

----check correlation bet app discrp lenght and user rating 

select 

    case
        when length(b.app_desc) <500 then 'Short'
        when length(b.app_desc) BETWEEN 500 and 1000 then 'Medium'
        else 'Long'
        end as description_length,
        avg(a.user_rating) as Average_rating

from AppleStore as a
join 
apple_discription_combined as b 
ON 
  a.id = b.id 
  
group by description_length
order by Average_rating DESC
  
----- check the top rated app by genre    

select 
prime_genre,
track_name,
user_rating

from (
  SELECT
  prime_genre,
  track_name,
  user_rating,
  RANK () OVER(PARTITION BY prime_genre order by user_rating DESC, rating_count_tot desc) as rank 
  from 
  AppleStore
  ) as a 
where 
a.rank = 1

       









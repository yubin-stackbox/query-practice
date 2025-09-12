/*
Problem: Number Of Units Per Nationality (stratascratch #10156)
Link: https://platform.stratascratch.com/coding/10156-number-of-units-per-nationality?code_type=3
Difficulty: Medium

Description:
Figure out how many different apartments are owned by people under 30, broken down by their nationality. Sort the result as the highest number of apartments.

Approach:
1. Subquery for data cleaning from the airbnb_hosts table
    - Retrieve the unique values for each host 
    - Retrieve necessary columns only
2. Join the subquery with the units table
3. Filter out to leave the people whose age is under 30 and unit type is the apartment
4. Group by the nationality for aggregation
5. Display nationality and the number of unique unit_id (different apartments)
6. Order by the number of apartments, highest first

Notes / Pitfalls:
- Data cleaning through subquerying
*/

SELECT nationality, COUNT(DISTINCT unit_id) apartment_count
FROM (SELECT DISTINCT host_id, nationality, age
      FROM airbnb_hosts) h 
JOIN airbnb_units u USING(host_id)
WHERE age < 30 AND unit_type = 'apartment'
GROUP BY nationality
ORDER BY apartment_count DESC

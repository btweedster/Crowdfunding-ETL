-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT backers_count, cf_id
FROM campaign
WHERE outcome = 'live'
ORDER BY backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT(*) as backers_count, b.cf_id
FROM backers b
LEFT JOIN campaign cm ON b.cf_id = cm.cf_id
WHERE cm.outcome = 'live'
GROUP BY b.cf_id
ORDER BY backers_count DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT ct.first_name, ct.last_name, ct.email, (cm.goal - cm.pledged) as Remaining_Goal_Amount
INTO email_contact_remaining_goal_amount
FROM campaign cm
LEFT JOIN contacts ct ON cm.contact_id = ct.contact_id
WHERE cm.outcome = 'live'
ORDER BY Remaining_Goal_Amount DESC;

-- Check the table
SELECT *
FROM email_contact_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT b.email, b.first_name, b.last_name, b.cf_id, cm.company_name, cm.description, cm.end_date, (cm.goal - cm.pledged) as left_of_goal
INTO email_backers_remaining_goal_amount
FROM backers b
LEFT JOIN campaign cm ON b.cf_id = cm.cf_id
WHERE cm.outcome = 'live'
ORDER BY b.last_name, b.email;

-- Check the table
SELECT *
FROM email_backers_remaining_goal_amount;
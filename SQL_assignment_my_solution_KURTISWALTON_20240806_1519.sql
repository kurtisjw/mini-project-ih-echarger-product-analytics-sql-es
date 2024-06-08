USE mini_project;

-- LEVEL 1
-- Question 1: Number of users with sessions

SELECT users.id, COUNT(sessions.id) AS session_count
FROM users
JOIN sessions ON users.id = sessions.user_id
GROUP BY users.id;

-- Question 2: Number of chargers used by user with id 1

SELECT COUNT(DISTINCT chargers.id) AS user_1_chargers
FROM chargers
JOIN sessions ON chargers.id = sessions.charger_id
JOIN users ON sessions.user_id = users.id
WHERE users.id = 1;


-- LEVEL 2

-- Question 3: Number of sessions per charger type (AC/DC):

SELECT chargers.type, COUNT(sessions.ID) AS sessions_per_charger_type
from chargers
JOIN sessions ON chargers.id = sessions.charger_id
GROUP BY chargers.type
ORDER BY sessions_per_charger_type;


-- Question 4: Chargers being used by more than one user

SELECT chargers.id, COUNT(DISTINCT sessions.user_id) AS distinct_users
FROM chargers
JOIN sessions ON chargers.id = sessions.charger_id
JOIN users ON sessions.user_id = users.id
GROUP BY chargers.id
HAVING distinct_users > 1;


-- Question 5: Average session time per charger

select * from sessions;

with time_minutes as
(
select charger_id, (strftime('%s', end_time) = strftime('%s', start_time))/60 as minutes
from sessions
)
select charger_id, round(avg(minutes),3) as avg_session_time
from time_minutes
group by charger_id;

-- LEVEL 3

-- Question 6: Full username of users that have used more than one charger in one day (NOTE: for date only consider start_time)

SELECT users.name, users.surname, COUNT(DISTINCT sessions.charger_ID) AS sessions_per_ID, DATE(sessions.start_time) as session_date
FROM users
JOIN sessions ON sessions.user_id = users.id
GROUP BY users.id, session_date
HAVING sessions_per_ID > 1;


-- Question 7: Top 3 chargers with longer sessions

SELECT charger_id, 
       SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS total_minutes
FROM sessions
GROUP BY charger_id
ORDER BY total_minutes DESC
LIMIT 3;


-- Question 8: Average number of users per charger (per charger in general, not per charger_id specifically)

SELECT AVG(distinct_users) AS avg_users_per_charger
FROM (
    SELECT charger_id, COUNT(DISTINCT user_id) AS distinct_users
    FROM sessions
    GROUP BY charger_id
) AS users_per_charger;



-- Question 9: Top 3 users with more chargers being used

SELECT user_id, COUNT(DISTINCT charger_id) as distinct_chargers
FROM sessions
GROUP by user_id
ORDER BY distinct_chargers DESC
LIMIT 3;



-- LEVEL 4

-- Question 10: Number of users that have used only AC chargers, DC chargers or both

SELECT DISTINCT(chargers.type) AS charger_type, sessions.user_id
FROM chargers
JOIN sessions on chargers.id = sessions.charger_id
GROUP BY user_id;


-- Question 11: Monthly average number of users per charger



-- Question 12: Top 3 users per charger (for each charger, number of sessions)




-- LEVEL 5

-- Question 13: Top 3 users with longest sessions per month (consider the month of start_time)
    
-- Question 14. Average time between sessions for each charger for each month (consider the month of start_time)
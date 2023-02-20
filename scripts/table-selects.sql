-- Staging Counts

SELECT COUNT(*)
FROM staging

-- Count of tweets for users with colin
SELECT
	u.username ,
	COUNT(*) AS Cnt
FROM `user` u 
INNER JOIN tweet t ON t.user_id  = u.id 
WHERE username LIKE '%colin%'
GROUP BY u.username 
ORDER BY 2 DESC

-- Number of users with colin
SELECT COUNT(*)
FROM `user` u 
WHERE username LIKE '%colin%'

-- Count of record in tweet
SELECT COUNT(*)
FROM tweet
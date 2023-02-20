use tweety;

-- Insert into user
INSERT INTO user (username)
SELECT DISTINCT user 
FROM staging;

-- Insert into tweet
INSERT INTO tweet (tweet, user_id)
SELECT
	s.tweet,
	u.id
FROM staging s 
INNER JOIN `user` u ON u.username = s.`user`;

-- Start time	Wed Feb 15 11:13:53 GMT 2023
-- Finish time	Wed Feb 15 11:14:36 GMT 2023
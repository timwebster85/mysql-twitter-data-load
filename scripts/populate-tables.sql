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

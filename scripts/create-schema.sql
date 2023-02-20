CREATE DATABASE tweety;

USE tweety;

CREATE TABLE staging 
(
  pop_type INT , 
  tweet_id BIGINT, 
  tweet_date TEXT, 
  query TEXT,
  user TEXT, 
  tweet TEXT
);

CREATE TABLE user (
    id int NOT NULL AUTO_INCREMENT,
    username text,
    PRIMARY KEY (id)
   );
   
CREATE TABLE tweet (
id int NOT NULL AUTO_INCREMENT,
tweet text,
user_id  integer,
PRIMARY KEY (id),
FOREIGN KEY (user_id) REFERENCES user(id)
 );
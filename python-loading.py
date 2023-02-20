import mysql.connector
import time

# Connect to the MySQL database
cnx = mysql.connector.connect(
    user="root", password="my-secret-pw", host="localhost", database="tweety"
)

# Create a cursor object
cursor = cnx.cursor()

# Define the query to load the data from the CSV file
query = "LOAD DATA INFILE '/var/lib/mysql-files/training.1600000.processed.noemoticon.csv' IGNORE INTO TABLE staging CHARACTER SET 	latin1 FIELDS TERMINATED BY ',' ENCLOSED BY '\"'	ESCAPED BY '' LINES TERMINATED BY '\n'"

# Start time
st = time.time()

# Execute the query
cursor.execute(query)

# Commit the changes
cnx.commit()

# End time
et = time.time()

elapsed_time = et - st
print('Execution time:', time.strftime("%H:%M:%S", time.gmtime(elapsed_time)))

# Close the cursor and connection
cursor.close()
cnx.close()

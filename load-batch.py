import mysql.connector
import os
import pandas as pd
import multiprocessing
import csv

def load_csv_to_mysql(csv_path, table_name):
    # Connect to the MySQL database
    cnx = mysql.connector.connect(user="root", password="my-secret-pw", host="localhost", database="tweety")

    # Create a cursor object
    cursor = cnx.cursor()

    # Define the query to load the data from the CSV file
    query = f"LOAD DATA INFILE '{csv_path}' IGNORE INTO TABLE {table_name} CHARACTER SET latin1 FIELDS TERMINATED BY ',' ENCLOSED BY '\"'	ESCAPED BY '' LINES TERMINATED BY '\n'"

    # Execute the query
    cursor.execute(query)

    # Commit the changes
    cnx.commit()

    # Close the cursor and connection
    cursor.close()
    cnx.close()

if __name__ == '__main__':
    # Define the path to the large CSV file and the table name to load it into
    # csv_path = 'data/training.1600000.processed.noemoticon.csv'
    csv_path = 'data/testdata.manual.2009.06.14.csv'
    table_name = 'staging'

    # Determine the size of each chunk (in number of rows)
    chunk_size = 10

    # Create a list of chunk file paths
    chunk_file_paths = []
    with open(csv_path, encoding='Latin_1') as f:
        chunks = pd.read_csv(f, header=None, chunksize=chunk_size)
        for chunk in chunks:
            chunk_file_path = f'{os.path.splitext(csv_path)[0]}_{len(chunk_file_paths)}.csv'
            chunk_file_paths.append(chunk_file_path)
            chunk.to_csv(chunk_file_path, index=False, header=False,quoting=csv.QUOTE_ALL)

    # Create a list of tuples containing the chunk file path and table name
    chunk_table_list = [(chunk_file_path, table_name) for chunk_file_path in chunk_file_paths]

    # Create a pool of worker processes
    pool = multiprocessing.Pool(processes=multiprocessing.cpu_count())

    # Use the pool to load each chunk into the table in parallel
    pool.starmap(load_csv_to_mysql, chunk_table_list)

    # Close the pool
    pool.close()
    pool.join()

    # Delete the chunk files
    for chunk_file_path in chunk_file_paths:
        os.remove(chunk_file_path)

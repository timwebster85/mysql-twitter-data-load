# Load twitter data into mysql

The purpose of this project was to load in data from a csv file into a mysql database for anaylsis.

Dataset:

Twitter Sentiment Analysis
http://help.sentiment140.com/for-students/

**Fast way to do this as I see it is a direct import into sql.**

*Note: I looked at other methods i.e chunking the file using Python and Pandas, but found it to be slow and because I am using a Docker image of mysql I was getting hindered by security issues with the instance (below error).*

`The MySQL server is running with the --secure-file-priv option so it cannot execute this statement`

# Steps to get this up and running
## Step 1 - build image

Build the docker image tagging it with "timssql"
`docker build -t timmsql .`

The build will do the following:
- Pull the lastest docker image of mysql.
- Copy the contents of data folder containing the csv files we want to load to `/var/lib/mysql-files/`
- Set the default password for the instance.
- Add the create-schema.sql file to the boot up scripts for mysql so that database gets created at run time.
- Expose port 3306 for use.

## Step 2 - run image

`docker run --detach --name=timmsql --publish 3306:3306 timmsql`

## Step 3 - connect to the instance

Using either DBeaver or MySQL Workbench connect to the instance:
- Server: `localhost`
- Port: `3306`
- Username: `root`
- Password: `my-secret-pw`

<mark>If using DBbeaver may have to add in useSSL = false and allowPublicKeyRetrieval = true</mark>

## Step 4 - Populate the staging table

Option1: Run the script [load-staging.sql](./scripts/load-staging.sql)

Option2: You can used the python file to load staging it does same as above [python-loading.py](./python-loading)

Timings are the same 30 - 40 seconds loadtime

## Step 5 - Populate user and tweet tables

Run the script [populate-tables.sql](./scripts/populate-tables.sql)

## Step 6 - Query data

Run the script [table-selects.sql](./scripts/table-selects.sql)

# Addtional notes

There are two csv files:

Sample data:
[testdata.manual.2009.06.14.csv](./data/testdata.manual.2009.06.14.csv)

Actual data 1600000 rows:
[training.1600000.processed.noemoticon.csv](./data/training.1600000.processed.noemoticon.csv)

## csv file format

- 0 - the polarity of the tweet (0 = negative, 2 = neutral, 4 = positive)
- 1 - the id of the tweet (2087)
- 2 - the date of the tweet (Sat May 16 23:58:44 UTC 2009)
- 3 - the query (lyx). If there is no query, then this value is NO_QUERY.
- 4 - the user that tweeted (robotickilldozr)
- 5 - the text of the tweet (Lyx is cool)

# Other notes



Command to copy files into docker container:

`docker cp training.1600000.processed.noemoticon.csv 638eb:/var/lib/mysql-files/`

Checking the path of secure_file_priv:

`SHOW VARIABLES LIKE "secure_file_priv"`

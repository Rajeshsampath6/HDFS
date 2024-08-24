#!/bin/bash

# Variables
URL="<your-url>"
HDFS_PATH="/user/hadoop/<directory>"
FILENAME=$(basename $URL)
TABLE_NAME="<table_name>"

# Fetch the data
wget $URL -O $FILENAME

# Store the data in HDFS
hdfs dfs -put $FILENAME $HDFS_PATH

# Hive commands to create table and load data
hive -e "CREATE TABLE IF NOT EXISTS $TABLE_NAME (
           <column1> <datatype>,
           <column2> <datatype>,
           ...
         )
         ROW FORMAT DELIMITED
         FIELDS TERMINATED BY ','
         STORED AS TEXTFILE;

         LOAD DATA INPATH '$HDFS_PATH/$FILENAME' INTO TABLE $TABLE_NAME;

         SELECT * FROM $TABLE_NAME LIMIT 10;"

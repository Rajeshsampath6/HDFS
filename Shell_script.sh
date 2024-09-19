crontab -e

0 0 * * * /path/to/your/script.sh


#!/bin/bash

# Variables
DATA_URL="https://www2.census.gov/programs-surveys/popest/datasets/2020-2021/state/totals/NST-EST2021-alldata.csv"
HDFS_DIR="/user/hadoop/pop_data"
LOCAL_FILE="NST-EST2021-alldata.csv"

# Download data
wget $DATA_URL -O $LOCAL_FILE

# Upload to HDFS
hadoop fs -mkdir -p $HDFS_DIR
hadoop fs -put $LOCAL_FILE $HDFS_DIR/

# Load data into Hive (assumes Hive is configured)
hive -e "
  USE pop_data_db;
  LOAD DATA INPATH '$HDFS_DIR/$LOCAL_FILE' INTO TABLE pop_data;
"

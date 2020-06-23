
    # create table STATEMENT from json file
    # for CSV files, use wither LazySimpleSerde or OpenCSVSerde
    # see: https://docs.aws.amazon.com/athena/latest/ug/csv.html
    create_table = \
        """CREATE EXTERNAL TABLE IF NOT EXISTS %s.%s (
        `id` int,
        `agency_identifier` string,
        `main_account_code` string,
        `account_title` string,
        `federal_account_code` string,
        `parent_toptier_agency_id` string
         )
         ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
         WITH SERDEPROPERTIES (
         'separatorChar' = ',',
         'quoteChar' = '\\"',
         'escapeChar' = '\\\\'
         ) LOCATION '%s'
         TBLPROPERTIES ('has_encrypted_data'='false');""" % ( database, table, s3_input )

    # fetching data: Query definitions
    #query_1 = "SELECT * FROM %s.%s where sex = 'F';" % (database, table)
    #query_2 = "SELECT * FROM %s.%s where age > 30;" % (database, table)

    # actions:
    # create the database
    res_db = create_athena_DB(database, regionName, DBbucket)
    sleep(0.5) # necessary, otherwise, check for query status

    # create table on the db
    res = run_query(create_table, database, s3_ouput)
    sleep(0.5) # necessary

    # run query 1
    result = getResults(DTquery, database, s3_ouput, s3bucketOutputPrefix, DBbucket, regionName)

    #return  jsonify({'task': task[0]})
    return result

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)


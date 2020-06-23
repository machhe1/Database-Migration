# ----- download the archive file and unzip it
cd /database 
wget usaspending-db_20200612.zip
sudo apt install unzip
unzip usaspending-db_20200612.zip -d usaspending-db_20200612


# - 2 - RESTORE AND INSPECT THE DATABASE
# ----- after we configured the database location in postgresql.conf, the 
# ----- record of the root user was lost, so we'lll recreate it
sudo -u postgres createuser root
sudo -u postgres createdb root

# ----- start psql to grant the privleges
sudo -u postgres psql
# or 
sudo -u postgres /usr/bin/psql

# ----- add SUPERUSER privleges 
# (sql) ALTER USER root WITH ENCRYPTED PASSWORD '<enter-password>';
# (sql) GRANT ALL PRIVILEGES ON DATABASE root TO root;
# (sql) ALTER USER root WITH SUPERUSER CREATEDB CREATEROLE;

# ----- now to restore the database
pg_restore --list usaspending-db_20200612 | sed '/MATERIALIZED VIEW DATA/D' > restore.list
# ----- the step below takes ~6 hours to complete 
pg_restore --jobs 16 --dbname postgresql://root:'<enter-password>'@localhost:5432/root --verbose --exit-on-error --use-list restore.list usaspending-db_20200612

# view a list of our restored tables
psql --dbname postgresql://root:'<enter-password>'@localhost:5432/root --command 'ANALYZE VERBOSE;' --echo-all --set ON_ERROR_STOP=on --set VERBOSITY=verbose --set SHOW_CONTEXT=always
pg_restore --list usaspending-db_20200612 | grep "MATERIALIZED VIEW DATA" > refresh.list

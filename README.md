# Database-Migration
[Slides](https://docs.google.com/presentation/d/1fZB80DsGWLlWrcUJ0LGq9JEN_1p5VqneoZt2a-miPm0/edit?usp=sharing)
# Overview
From the past few years, migration to cloud is exponentially increasing. So, it is important to realize how business can best utilize the cloud. One of the biggest issues enterprise are having today is moving their data from on-premises databases to their cloud data storage.

# Data
USAspending Database as a [Complete PostgreSQL Dump Archive](https://files.usaspending.gov/database_download/) generated on a **monthly** basis.

# Database Migration Strategy
  1. Obtain an existing database
  2. Migrate data to new S3 Data Lake
  3. Biuld API to access Data Lake
  4. Valide Queries to new S3 Data Lake return same result as Original Database

# Architecture
![eh](https://github.com/machhe1/Database-Migration/blob/master/images/Capture.PNG)

# Installation
  1. Set up a PostgreSQL database and restore the full database (~700GB) from the archive file (~60GB).
  2. Configure S3.
  3. Migrate each table (~60 tables) from PostgreSQL to S3 Via Python.
  4. Configure Athena pointing to S3.
  5. Set up a web server with Apache and UI with Flask.

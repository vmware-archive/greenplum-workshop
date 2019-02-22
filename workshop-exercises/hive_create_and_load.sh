#!/usr/bin/env bash

###########################################################################################################
# Script to use in conjunction with the PXF exercise.
#
# Creates a plain text CSV file and copies it into HDFS. We create a Hive external table to "sit" on top
# of this file.
#
# We then create a Hive table using the PARQUET format and load it from the external table.
###########################################################################################################

# Utility Functions

function echo_eval
{
    echo $@
    eval $@
}

# Variable declarations

DAT_FILE='./providers_part1.csv'
HDFS_DAT_DIR='/tmp/data/providers'

# Creation of our data file

echo "Create '$DAT_FILE' data file"

cat << EOF >  $DAT_FILE
"provider_id","provider_name","specialty","address_street","address_city","address_state","address_zip"
"P247884957","Merrill Z. Decker"," Dermatology ","3337 Sed Ave","Bridgeport","CT","12297"
"P331044626","Fleur F. Boyer"," Dermatology ","223-2147 Penatibus Avenue","Bear","DE","58274"
"P118685693","Erich E. Spears"," General hematology ","5961 Sed Rd.","Houston","Texas","85501"
"P802173626","Emerson G. Petersen"," General Practitioner ","9426 Eu Rd.","Harrisburg","PA","93940"
"P485678730","Marah Z. Horn"," Clinical biology ","152-8175 Suspendisse Road","Atlanta","GA","21571"
"P190279041","Kristen V. Blake"," Internal medicine ","P.O. Box 944, 3305 Eu Avenue","Las Vegas","NV","58451"
"P541170364","Dora T. Heath"," Dermatology ","P.O. Box 974, 6415 Arcu. Rd.","Georgia","Georgia","36357"
"P635145420","Adele J. Allison"," Cardiology ","8679 Semper Av.","Springfield","MO","71576"
"P961868819","Dana O. Gilliam"," General Practitioner ","7379 Eu Avenue","Great Falls","MT","61200"
"P732096570","Elizabeth W. Frost"," Orthopaedics ","713-7204 Fermentum Street","Wyoming","WY","73867"
"P742341364","Imelda E. Goff"," Tropical medicine ","345 Nullam Road","Rochester","MN","48126"
"P809710281","Melinda O. Griffith"," Pathology ","358-7710 Sed Ave","West Valley City","UT","38380"
"P861124815","Lars U. Buck"," Podiatric Surgery ","P.O. Box 212, 8726 Nulla Rd.","Lowell","MA","16412"
"P837529935","Raja L. Burton"," Neurosurgery ","1856 Nisl. Avenue","Fayetteville","AR","72483"
"P307918645","Linus H. Osborne"," Pathology ","P.O. Box 156, 8639 Lorem, Ave","Cheyenne","WY","71428"
"P004165295","Thane O. Richard"," Radiology ","Ap #256-3260 Nulla Street","Augusta","Georgia","55956"
"P693623397","Dorian B. Harrell"," Infectious diseases ","136 Mi Street","Kaneohe","Hawaii","47327"
"P992476391","Brennan U. Franks"," Cardiology ","P.O. Box 843, 1802 Aliquam St.","Baltimore","MD","76971"
"P941322877","Amanda A. Stanley"," Neurology ","6853 Magna. St.","Rockville","MD","40156"
"P124535465","Amena W. Soto"," Infectious diseases ","1120 Accumsan Street","Austin","Texas","91631"
"P770815171","Margaret M. Quinn"," Internal medicine ","P.O. Box 125, 2648 Consequat Av.","Duluth","MN","95671"
"P536973426","Jameson X. Delaney"," Nurse Practitioner","P.O. Box 375, 9837 Placerat. Av.","Rochester","MN","44496"
"P142255781","Garrison R. Macdonald"," Geriatrics ","1303 Mi, Avenue","Pittsburgh","PA","81163"
"P084521574","Kasper T. Rojas"," Tropical medicine ","P.O. Box 840, 7560 Tellus. St.","Springfield","MA","58042"
"P546736363","Evelyn Y. Edwards"," Nuclear medicine ","9868 Faucibus Rd.","Kailua","HI","52532"
"P418854238","Jordan H. Gross"," General Practitioner ","Ap #277-6938 Nunc Av.","Duluth","MN","64690"
"P354366912","Dominique T. Oneal"," europhysiology ","P.O. Box 696, 8160 Ut Rd.","Shreveport","Louisiana","95308"
"P011948784","Carson M. Padilla"," Nephrology ","P.O. Box 515, 5196 Euismod Avenue","Allentown","Pennsylvania","52764"
"P275959088","Gay F. Anderson"," Rheumatology ","4006 Nam St.","Atlanta","GA","77089"
"P995048374","Mason T. Coleman"," General Practitioner ","7290 Ut, Rd.","South Portland","Maine","37340"
"P762370192","Miranda K. Clayton"," Geriatrics ","P.O. Box 724, 371 Dolor Rd.","Lewiston","ME","56466"
"P681464849","Hilel L. Mullen"," Otorhinolaryngology ","P.O. Box 176, 1839 Sed Avenue","Baton Rouge","LA","92637"
EOF

# Make our data directory in HDFS

echo_eval "hdfs dfs -mkdir -p $HDFS_DAT_DIR"
[[ $? != 0 ]] && { echo Error creating dir in hdfs; exit 1; }

# Copy our data file into the newly created data directory

echo_eval "hdfs dfs -put $DAT_FILE $HDFS_DAT_DIR"
[[ $? != 0 ]] && { echo Error on hdfs put ; exit 1; }

# Create the Hive PARQUET table and the Hive External Table

echo Create Hive tables
hive << EOF
create table providers_parquet (
  provider_id string,
  provider_name string,
  specialty string,
  address_street string,
  address_city string,
  address_state string,
  address_zip string
)
 row format delimited fields terminated by ',' 
stored as parquet location '/user/hive/warehouse/providers_parquet' ;

create external table providers_ext (
  provider_id string,
  provider_name string,
  specialty string,
  address_street string,
  address_city string,
  address_state string,
  address_zip string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE 
LOCATION '$HDFS_DAT_DIR'
tblproperties ("skip.header.line.count"="1")
;

exit;
EOF

[[ $? != 0 ]] && { echo Error during hive table creations ; exit 1; }

# Let's look at a few records

echo_eval "hive -e 'select * from providers_ext limit 10'"

# OK, time to load our Hive PARQUET table

echo_eval "hive -e 'insert into providers_parquet select * from providers_ext'"

# We could clean up and remove our generated data file but who cares ...

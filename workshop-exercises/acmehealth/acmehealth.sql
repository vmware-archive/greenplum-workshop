drop table if exists members;
CREATE TABLE members (
  Member_ID varchar(255),
  Name varchar(255),
  SSN varchar(255),
  Street_Address varchar(255),
  City varchar(255),
  State varchar(50),
  Zip int,
  Phone varchar(100),
  Date_of_Birth Date,
  Credit_Card_No varchar(255),
  Hash_Pin varchar(8)
);

\COPY members FROM '/home/gpuser/acmehealth/members.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;

select count(*) from members;
select gp_read_error_log('members');
analyze members;

drop table if exists claim_items;
CREATE TABLE claim_items (
  Claim_Item_ID int,
  Claim_ID int,
  Service_Code varchar(255),
  Amount_Claimed decimal(30,2)
);

\COPY claim_items FROM '/home/gpuser/acmehealth/claim_items.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;

select count(*) from claim_items;
select gp_read_error_log('claim_items');
analyze claim_items;

drop table if exists claims;
CREATE TABLE claims (
  Claim_ID INT,
  Member_ID varchar(255),
  Provider_ID varchar(255),
  Date_Of_Service varchar(255)
);

\COPY claims FROM '/home/gpuser/acmehealth/claims.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;
select count(*) from claims;
select gp_read_error_log('claims');
analyze claims;

drop table if exists services;
CREATE TABLE services (
  Service_Code varchar(255),
  Service_Description varchar(255),
  Amount_Covered varchar(100)
);

\COPY services FROM '/home/gpuser/acmehealth/services.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;

select count(*) from services;
select gp_read_error_log('services');
analyze services;

drop table if exists providers;
CREATE TABLE providers (
  Provider_ID varchar(255),
  Provider_Name varchar(255),
  Specialty varchar(255),
  Address_Street varchar(255),
  Address_City varchar(255),
  Address_State varchar(50),
  Address_Zip varchar(10)
);

\COPY providers FROM '/home/gpuser/acmehealth/providers.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;
select count(*) from providers;
select gp_read_error_log('providers');
analyze providers;

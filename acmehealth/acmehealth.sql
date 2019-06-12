drop table if exists members;
CREATE TABLE members (
  member_id varchar(255),
  name varchar(255),
  ssn varchar(255),
  street_address varchar(255),
  city varchar(255),
  state varchar(50),
  zip int,
  phone varchar(100),
  date_of_birth Date,
  credit_card_no varchar(255),
  hash_pin varchar(8)
);

\COPY members FROM './members.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 10 ROWS;

select count(*) from members;
select gp_read_error_log('members');
analyze members;

drop table if exists claim_items;
CREATE TABLE claim_items (
  claim_item_id int,
  claim_id int,
  service_code varchar(255),
  amount_claimed decimal(30,2)
);

\COPY claim_items FROM './claim_items.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 10 ROWS;

select count(*) from claim_items;
select gp_read_error_log('claim_items');
analyze claim_items;

drop table if exists claims;
CREATE TABLE claims (
  claim_id INT,
  member_id varchar(255),
  provider_id varchar(255),
  date_of_service varchar(255)
);

\COPY claims FROM './claims.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 10 ROWS;
select count(*) from claims;
select gp_read_error_log('claims');
analyze claims;

drop table if exists services;
CREATE TABLE services (
  service_code varchar(255),
  service_description varchar(255),
  amount_covered varchar(100)
);

\COPY services FROM './services.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 10 ROWS;

select count(*) from services;
select gp_read_error_log('services');
analyze services;

drop table if exists providers;
CREATE TABLE providers (
  provider_id varchar(255),
  provider_name varchar(255),
  specialty varchar(255),
  address_street varchar(255),
  address_city varchar(255),
  address_state varchar(50),
  address_zip varchar(10)
);

\COPY providers FROM './providers.csv' DELIMITER ',' CSV HEADER LOG ERRORS SEGMENT REJECT LIMIT 10 ROWS;
select count(*) from providers;
select gp_read_error_log('providers');
analyze providers;

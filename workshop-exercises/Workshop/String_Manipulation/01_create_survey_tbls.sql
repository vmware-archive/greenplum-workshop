set search_path to public;


\set tbl_name public.stage_data

drop table if exists :tbl_name;
create table :tbl_name(
    table_row text
)
distributed randomly;


\set tbl_name public.survey_data

drop table :tbl_name;
create table :tbl_name (
    id        numeric,   -- relative order of var in sequence
    scf_var   varchar,   -- SCF variable name
    mivn      varchar,   -- MR Interview variable name
    var_ind   varchar,   -- numeric/character variable indicator
    var_evr   varchar,   -- flag for extended verbatim response
    var_label text
)
distributed randomly
;

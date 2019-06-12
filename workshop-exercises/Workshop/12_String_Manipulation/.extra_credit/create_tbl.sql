\set ext_tbl public.ext_fixed_format
drop external table if exists :ext_tbl;
create external table :ext_tbl (
    id        numeric,   -- relative order of var in sequence
    scf_var   varchar,   -- SCF variable name
    mivn      varchar,   -- MR Interview variable name
    var_ind   varchar,   -- numeric/character variable indicator
    var_evr   varchar,   -- flag for extended verbatim response
    var_label text
)
   LOCATION ('gpfdist://gpdb-sandbox:8081/survey*.fixed')
   FORMAT 'CUSTOM' (formatter=fixedwidth_in,
             id=8, scf_var=10, mivn=17, var_ind=2, var_evr=2, var_label=61)
;

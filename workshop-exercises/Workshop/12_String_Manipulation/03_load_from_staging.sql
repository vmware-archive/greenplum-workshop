insert into public.survey_data
select
rtrim(substring (table_row from 1 for 9))::numeric,
rtrim(substring (table_row from 11 for 7)),
rtrim(substring (table_row from 19 for 18)),
rtrim(substring (table_row from 38 for 1)),
rtrim(substring (table_row from 40 for 1)),
rtrim(substring (table_row from 42 for 60))
from public.stage_data
;

/*
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
         1         2         3         4         5         6         7         
105       X102    Q7A2               N   X102_Q7A2: S/P: RELAT TO R
109               Q16A2_CHKCMT       C V X104_Q16A2: EDT: S/P: AGE?
109.01            Q16A2_CHK2         N   X104_Q16A2: EDT: S/P: AGE?
109.02            Q16A2_CHK2CMT      C V X104_Q16A2: EDT: S/P: AGE?
110       NULL    Q19A2              N   NULL_Q19A2: S/P: 18 OR OVER?
*/

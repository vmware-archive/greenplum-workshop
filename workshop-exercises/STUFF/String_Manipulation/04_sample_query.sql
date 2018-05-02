select
      id,
      scf_var,
      split_part(var_label, ': ', 1) as scf_full,
      substr(split_part(var_label, ': ', 1),
             position('_' in split_part(var_label, ': ', 1)) + 1) as scf_sub,
      var_label
from public.survey_data
where split_part(var_label, ': ', 2) like 'PERSON_%'
limit 10
;

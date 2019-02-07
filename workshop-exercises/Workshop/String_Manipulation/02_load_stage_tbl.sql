\COPY public.stage_data FROM './survey_data1.txt' DELIMITER '~' LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;

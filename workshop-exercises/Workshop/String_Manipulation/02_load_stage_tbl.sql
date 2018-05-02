\COPY public.stage_data FROM '/home/gpuser/Exercises/String_Manipulation/survey_data1.txt' DELIMITER '~' LOG ERRORS SEGMENT REJECT LIMIT 50 ROWS;

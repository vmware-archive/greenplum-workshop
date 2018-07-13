SELECT  gp_segment_id, count(*)
FROM faa.otp_r
GROUP BY gp_segment_id ORDER BY gp_segment_id;

SELECT  gp_segment_id, count(*)
FROM faa.bad_distro
GROUP BY gp_segment_id ORDER BY gp_segment_id;

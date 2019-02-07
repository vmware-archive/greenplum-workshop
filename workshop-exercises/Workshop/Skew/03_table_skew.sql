SELECT  'otp_r' as "Table", gp_segment_id as "SegID", count(*) as "Count"
FROM faa.otp_r
GROUP BY gp_segment_id
UNION
SELECT  'bad_distro', gp_segment_id, count(*)
FROM faa.bad_distro
GROUP BY gp_segment_id
ORDER BY "Table", "SegID";

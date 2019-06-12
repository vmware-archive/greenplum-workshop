
SELECT  gp_segment_id, count(*)
FROM claims
GROUP BY gp_segment_id ORDER BY gp_segment_id;

SELECT  gp_segment_id, count(*)
FROM claims
GROUP BY gp_segment_id ORDER BY gp_segment_id;

SELECT  gp_segment_id, count(*)
FROM services
GROUP BY gp_segment_id ORDER BY gp_segment_id;

SELECT  gp_segment_id, count(*)
FROM providers
GROUP BY gp_segment_id ORDER BY gp_segment_id;

SELECT  gp_segment_id, count(*)
FROM members
GROUP BY gp_segment_id ORDER BY gp_segment_id;

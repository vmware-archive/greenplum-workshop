alter table d_airports add column location geography;
update d_airports set location = ST_MakePoint(longitude, latitude)::geography;

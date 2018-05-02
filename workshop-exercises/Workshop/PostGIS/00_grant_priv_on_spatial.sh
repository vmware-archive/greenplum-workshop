sudo -i -u gpadmin psql -d gpuser -c 'grant all privileges on public.spatial_ref_sys to gpuser';
sudo -i -u gpadmin psql -d gpuser -c 'grant all privileges on public.geometry_columns to gpuser';


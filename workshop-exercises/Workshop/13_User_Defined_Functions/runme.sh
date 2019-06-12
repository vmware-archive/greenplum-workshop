psql -f 01_overload.sql
read -p "Push Enter to Continue"
psql -f 02_dynamic.sql
read -p "Push Enter to Continue"
psql -f 03_reciprocal.sql
read -p "Push Enter to Continue"
psql -f 04_pymax.sql
read -p "Push Enter to Continue"
sudo -i -u gpadmin psql -d gpuser -f /home/gpuser/Exercises/User_Defined_Functions/04_pymax.sql
sudo -i -u gpadmin psql -d gpuser -c "grant execute on function pymax(int,int) to gpuser;"
psql -f  -c "select pymax(1,33);"
sudo -i -u gpadmin psql -d gpuser -f /home/gpuser/Exercises/User_Defined_Functions/05_create_secret.sql
psql -f 06_secret_sum.sql
read -p "Push Enter to Continue"
psql -f 07_define_route_type.sql
read -p "Push Enter to Continue"
psql -f 08_show_routes.sql
read -p "Push Enter to Continue"

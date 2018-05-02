DIR=$PWD
python 01_whoami.py
read -p "Press Enter to Continue"
psql -f 02_os_cmd_pythonu.sql 
read -p "Press Enter to Continue"
sudo -i -u gpadmin psql -d gpuser -f $DIR/02_os_cmd_pythonu.sql
sudo -i -u gpadmin psql -d gpuser -c "grant execute on function public.os_cmd_pythonu(text) to gpuser;"
read -p "Press Enter to Continue"
psql -c "select * from public.os_cmd_pythonu('whoami');"
read -p "Press Enter to Continue"
psql -c "select * from public.os_cmd_pythonu('cat /etc/system-release');"
psql -f 02_os_cmd_container.sql
read -p "Press Enter to Continue"
psql -c "select * from public.os_cmd_container('cat /etc/system-release');" 
read -p "Press Enter to Continue"
psql -c "select * from public.os_cmd_container('whoami');"
psql -f numpy_setup.sql 
read -p "Press Enter to Continue"
psql -f numpy_define_means.sql 
read -p "Press Enter to Continue"
psql -f numpy_calculate_means.sql 


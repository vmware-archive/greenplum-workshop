more  01_whoami.py
read -p "Press Enter to Continue"
cat  02_os_cmd_pythonu.sql 
read -p "Press Enter to Continue"
echo "grant execute on function public.os_cmd_pythonu(text) to gpuser;"
read -p "Press Enter to Continue"
echo "select * from public.os_cmd_pythonu('whoami');/
read -p "Press Enter to Continue"
echo "select * from public.os_cmd_pythonu('cat /etc/system-release');"
cat 02_os_cmd_container.sql
read -p "Press Enter to Continue"
echo "select * from public.os_cmd_container('cat /etc/system-release');" 
read -p "Press Enter to Continue"
echo "select * from public.os_cmd_container('whoami');"
cat numpy_setup.sql 
read -p "Press Enter to Continue"
cat numpy_define_means.sql 
read -p "Press Enter to Continue"
cat numpy_calculate_means.sql 

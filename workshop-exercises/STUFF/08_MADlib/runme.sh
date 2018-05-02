psql -f 01_summary.sql
read -p "Press enter to continue"
psql -f 02_train_model.sql
read -p "Press enter to continue"
psql -f 03_predict.sql
read -p "Press enter to continue"

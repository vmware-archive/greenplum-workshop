source $HOME/.bash_profile

SQL=$(find $HOME -name 02_create_ext_web_table.sql | head -1)

[[ -r $SQL ]] && psql -d gpuser -f $SQL


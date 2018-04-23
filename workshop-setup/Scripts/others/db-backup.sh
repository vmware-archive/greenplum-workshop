gpbackup -backup-dir '/data4/db-bkup' \
         -compression-level 5 \
         -dbname gpuser

gpbackup -backup-dir '/data4/db-bkup' \
         -compression-level 5 \
         -dbname otherdb \
         -include-schema faa

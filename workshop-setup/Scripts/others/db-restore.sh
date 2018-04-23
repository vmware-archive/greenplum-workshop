gpconfig -s gp_enable_query_metrics | grep -qE '^Master.*:[[:space:]]+off
if [[ $? -ne 0 ]]; then
    gpconfig -c gp_enable_query_metrics -v on
    gpconfig -c shared_preload_libraries -v '\$libdir/metrics_collector,\$libdir/gp_wlm

    gpstop -ra -M fast
fi

gprestore -backup-dir '/data4/db-bkup' \
         --timestamp 20180411155142 \
         --with-globals \
         --create-db \
         --jobs 4

gprestore -backup-dir '/data4/db-bkup' \
         --timestamp 20180411160544 \
         --with-globals \
         --create-db \
         --jobs 4


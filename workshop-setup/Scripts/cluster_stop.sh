gptext-stop

[[ $? == 0 ]] && zkManager stop

[[ $? == 0 ]] && gpstop -M fast -a

gpstart -a

[[ $? == 0 ]] && zkManager start

[[ $? == 0 ]] && gptext-start

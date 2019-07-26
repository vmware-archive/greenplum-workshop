if [[ $(which gptext-stop 2>/dev/null) ]]; then
    gptext-stop
    [[ $? != 0 ]] && echo 'Problems stopping GPText'
    zkManager stop
    [[ $? != 0 ]] && echo 'Problems stopping zkManager'
fi

[[ $? == 0 ]] && gpstop -M fast -a

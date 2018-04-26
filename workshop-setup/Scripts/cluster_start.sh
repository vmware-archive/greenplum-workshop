gpstart -a

# Check if GPText is installed before trying to start it
if [[ $? == 0 && $(which zkManager 2>/dev/null) ]]; then
    zkManager start
    [[ $? == 0 ]] && gptext-start
fi

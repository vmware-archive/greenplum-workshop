for x in `cat files_to_check.txt`
do
   echo $x
   sudo strings $x | head -20
done


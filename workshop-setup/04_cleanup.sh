# Set the Exercise directory based on the location of execution
export HD=$(pwd | sed  's?/gpuser.*?gpuser/Exercises?')

set -o errexit

SCHEMA=faa
echo "This script will drop the existing '$SCHEMA' schema if it exists."
read -n 1 -p "Proceed [y|N]? " ans

if [ $ans = "n" ] || [ $ans = "N" ] || [ "x$ans" = "x" ]
then
    echo Exiting ...
    exit 0
fi

psql -ec 'drop schema if exists $SCHEMA cascade'
psql -ec 'create schema $SCHEMA' || { echo "Problem with creating the '$SCHEMA' schema"; exit 1; }

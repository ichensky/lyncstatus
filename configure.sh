if [ ! -f ~/.pgpass ]
then
    echo "~/.pgpass file not exist" 1>&2
    exit 64
fi

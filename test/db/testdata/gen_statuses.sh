#!/bin/sh

echo "" > tmp_statuses
echo "insert into status values (default, 'free', 'free status desc');" >> tmp_contacts
echo "insert into status values (default, 'idle', 'idle status desc');" >> tmp_contacts
echo "insert into status values (default, 'busy', 'busy status desc');" >> tmp_contacts
echo "insert into status values (default, 'away', 'away status desc');" >> tmp_contacts
echo "insert into status values (default, 'some', 'some status desc');" >> tmp_contacts

mv tmp_statuses $(dirname $0)/statuses.sql
rm tmp

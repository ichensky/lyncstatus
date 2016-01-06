pgpass_file=~/.pgpass
pgpass_user=$(db_hostname):$(db_port):$(db_database):$(db_username):

db_userpassword=$(shell cat $(pgpass_file) | \
	grep $(pgpass_user) | grep -oE "[^:]+$$")

sql=psql -h $(db_hostname) -p $(db_port) -U $(db_username) -d $(db_database)



test_db=$(test)/db
testdata=$(test_db)/testdata

## GEN
db_test_gen_contacts: 
	sh $(testdata)/gen_contacts.sh

## Execute
db_test_apply_contacts:
	$(sql) -f $(testdata)/contacts.sql

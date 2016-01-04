# local qa staging prod
type=local
pgpass_filename=~/.pgpass

include etc/*.cfg
include etc/usr/*.cfg

pgpass_entity=$(db_hostname):$(db_port):$(db_database):$(db_username):
sql=$(psql -h host -p 5432 -U lyncspy -d lyncspydb)

all:

db_createuser:
	pass=$(shell cat $(pgpass_filename) | \
	grep $(pgpass_entity) | \
	sed s/$(pgpass_entity)//g)
	echo ${pass}

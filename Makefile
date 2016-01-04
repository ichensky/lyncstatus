# local qa staging prod
type=local

# path to default config files
cfg=etc/*.cfg
# path to user config files
cfg_usr=etc/usr/$(type)/*.cfg

include $(cfg)
-include $(cfg_usr)

pgpass_file=~/.pgpass
pgpass_user=$(db_hostname):$(db_port):$(db_database):$(db_username):

db_superuserpassword=$(shell cat $(pgpass_file) | \
	grep "$(db_hostname):$(db_port)" | \
	grep ":$(db_superusername):" | grep -oE "[^:]+$$")

db_userpassword=$(shell cat $(pgpass_file) | \
	grep $(pgpass_user) | grep -oE "[^:]+$$")

ssql=psql -h $(db_hostname) -p $(db_port) -U $(db_superusername)

all: db_createuser
	echo "TODO:"

db_createuser:
	$(ssql) -c \
	"create user $(db_username) with password '$(db_userpassword)'"

db_dropuser:
	$(ssql) -c \
	"drop user $(db_username)"

db_createdatabase:
	$(ssql) -c \
	"create database $(db_database)"

db_granduser:
	$(ssql) -c \
	"grant all privileges on database $(db_database) to $(db_username)"

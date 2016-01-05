

pgpass_file=~/.pgpass
pgpass_user=$(db_hostname):$(db_port):$(db_database):$(db_username):

db_superuserpassword=$(shell cat $(pgpass_file) | \
	grep "$(db_hostname):$(db_port)" | \
	grep ":$(db_superusername):" | grep -oE "[^:]+$$")

db_userpassword=$(shell cat $(pgpass_file) | \
	grep $(pgpass_user) | grep -oE "[^:]+$$")

ssql=psql -h $(db_hostname) -p $(db_port) -U $(db_superusername)
sql=psql -h $(db_hostname) -p $(db_port) -U $(db_username) -d $(db_database)

db=$(src)/db
db_migrations_file=$(db)/migrations.sql

all: 
	echo "TODO:"

db_create_user:
	$(ssql) -c \
	"create user $(db_username) \
	with password '$(db_userpassword)'"

db_drop_user:
	$(ssql) -c "drop user $(db_username)"

db_create_database:
	$(ssql) -c "create database $(db_database)"

db_drop_database: db_kill_connections 
	$(ssql) -c "drop database if exists $(db_database)"

db_grand_user:
	$(ssql) -c \
	"grant all privileges \
	on database $(db_database) to $(db_username)"

db_kill_connections:
	$(ssql) -c \
	"select pg_terminate_backend(pg_stat_activity.pid) \
	from pg_stat_activity \
	where pg_stat_activity.datname='$(db_database)'"

db_recreate_database: db_drop_database db_create_database db_grand_user

db_apply_migrations:
	$(sql) -f $(db_migrations_file)

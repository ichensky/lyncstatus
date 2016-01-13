pgpass_file=~/.pgpass

db_hostname=$(shell echo $(db_pgpass) | awk -F: '{ print $$1 }') 
db_port=$(shell echo $(db_pgpass) | awk -F: '{ print $$2 }') 
db_database=$(shell echo $(db_pgpass) | awk -F: '{ print $$3 }') 
db_username=$(shell echo $(db_pgpass) | awk -F: '{ print $$4 }') 

db_shostname=$(shell echo $(db_spgpass) | awk -F: '{ print $$1 }') 
db_sport=$(shell echo $(db_spgpass) | awk -F: '{ print $$2 }') 
db_sdatabase=$(shell echo $(db_spgpass) | awk -F: '{ print $$3 }') 
db_susername=$(shell echo $(db_spgpass) | awk -F: '{ print $$4 }') 

db_password=$(shell cat $(pgpass_file) | \
	grep -F $(db_pgpass) | grep -oE "[^:]+$$")

db_spassword=$(shell cat $(pgpass_file) | \
	grep -F $(db_spgpass) | grep -oE "[^:]+$$")

ssql=psql -h $(db_shostname) -p $(db_sport) -U $(db_susername)
sql=psql -h $(db_hostname) -p $(db_port) -U $(db_username) -d $(db_database)

db=$(src)/db
db_migrations_file=$(db)/migrations.sql
testdata=$(test)/db/testdata

db_info:
	@echo "host: "$(db_hostname) "\n"\
	"port: "$(db_port) "\n"\
	"database: "$(db_database) "\n"\
	"username: "$(db_username) "\n"\
	"password: "$(db_password) "\n"\
	"shost: "$(db_shostname) "\n"\
	"sport: "$(db_sport) "\n"\
	"sdatabase: "$(db_sdatabase) "\n"\
	"susername: "$(db_susername) "\n"\
	"spassword: "$(db_spassword)

db_create_user:
	$(ssql) -c \
	"create user $(db_username) \
	with password '$(db_password)'"

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

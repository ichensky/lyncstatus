test_db=$(test)/db
testdata=$(test_db)/testdata

## GEN
db_test_gen: db_test_gen_contacts db_test_gen_states

db_test_gen_contacts: 
	sh $(testdata)/gen_contacts.sh

db_test_gen_states: 
	sh $(testdata)/gen_states.sh

## Execute
db_test_apply: db_test_apply_contacts db_test_apply_states

db_test_apply_contacts:
	$(sql) -f $(testdata)/contacts.sql

db_test_apply_states:
	$(sql) -f $(testdata)/states.sql

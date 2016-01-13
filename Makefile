# local qa staging prod
prefix=/usr/local

bin=bin
etc=etc
usr_etc=usr/$(etc)

# path to default config files
cfg=$(etc)/*.cfg
# path to user config files
usr_cfg=$(usr_etc)/*.cfg

dist=dist
gen=gen
src=src
test=test
backend=$(src)/backend


include $(cfg)
-include $(usr_cfg)

include $(gen)/db.mk
include $(gen)/db_testdata.mk

include $(gen)/backend.mk

all: get build

build: backend_build

get: backend_get_packages

install:
	cp -vr $(dist)/* $(prefix) 

dist:
	mkdir -vp $(dist)
	cp -vr $(backend)/bin $(dist)
	cp -vr $(backend)/etc $(dist)

clean: clean_dist backend_clean
	rm -rf bin $(dist)

clean_dist:
	rm -rf $(dist)


info:
	echo $$(set)

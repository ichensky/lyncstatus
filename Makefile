# local qa staging prod
type=local

prefix=/usr/local

bin=bin
etc=etc
etc_usr=$(etc)/usr

# path to default config files
cfg=$(etc)/*.cfg
# path to user config files
cfg_usr=$(etc_usr)/$(type)/*.cfg

dist=dist
gen=gen
src=src
test=test
backend=$(src)/backend


include $(cfg)
-include $(cfg_usr)

include $(gen)/db.mk
include $(gen)/db_testdata.mk

include $(gen)/backend.mk

build: backend_build

get: backend_get_packages

dist:
	mkdir -vp dist
	cp -vr $(backend)/bin dist
	cp -vr $(backend)/etc dist

clean_dist:
	rm -rf dist

clean: clean_dist backend_clean
	rm -rf bin dist

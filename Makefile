# local qa staging prod
type=local

# path to default config files
cfg=etc/*.cfg
# path to user config files
cfg_usr=etc/usr/$(type)/*.cfg

gen=gen
src=src
test=test
backend=$(src)/backend

GOPATH:=${PWD}/$(backend)/packages:${PWD}/$(backend)
export GOPATH

include $(cfg)
-include $(cfg_usr)

include $(gen)/db.mk
include $(gen)/db_testdata.mk

include $(gen)/backend.mk

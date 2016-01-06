# local qa staging prod
type=local

# path to default config files
cfg=etc/*.cfg
# path to user config files
cfg_usr=etc/usr/$(type)/*.cfg

src=src
test=test

include $(cfg)
-include $(cfg_usr)

include gen/db.mk
include gen/db_testdata.mk

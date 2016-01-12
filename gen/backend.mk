backend_cfg=$(backend)/cfg
backend_collector_cfg=$(backend_cfg)/collector.cfg

backend_collector=collector
backend_bin=$(backend)/bin
backend_collector_app=$(backend_bin)/collector

backend_build:
	echo "TODO:"

backend_build_libs:
	echo "TODO:"

backend_build_collector:
	go build -v -o $(backend_collector_app) \
		$(backend_collector)

	cat $(backend_collector_cfg) > $(backend_bin)/collector.cfg



backend_get_packages:
	echo $(GOPATH)
	go get -d -u -v github.com/lib/pq


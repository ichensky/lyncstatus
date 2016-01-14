GOPATH:=${PWD}/$(backend)/packages:${PWD}/$(backend)
export GOPATH

backend_cfg=$(backend)/cfg
backend_collector_cfg=$(backend_cfg)/collector.cfg

backend_collector=collector
backend_bin=$(backend)/bin

backend_build: backend_build_collector backend_build_report

backend_build_collector:
	go build -v -o $(bin)/lyncspycollector \
		$(backend_collector)

backend_build_report:
	go build -v -o $(bin)/lyncspyreport \
		$(backend_collector)

backend_get_packages:
	echo $(GOPATH)
	go get -d -u -v github.com/lib/pq

backend_clean:
	rm -rf ${PWD}/$(backend)/packages


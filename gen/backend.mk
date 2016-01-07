backend_build:
	echo "TODO:"

backend_build_libs:
	go build -v -x -o $(backend)/bin/pgpass $(backend)/src/pgpass/pgpass.go

backend_build_collector:
	go build -v -o $(backend)/bin/collector $(backend)/src/collector/collector.go 



backend_get_packages:
	echo $(GOPATH)
	go get -d -u -v github.com/lib/pq
	go get -d -u -v github.com/BurntSushi/toml


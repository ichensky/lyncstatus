backend_build:
	go build -v -o $(backend)/bin/collector $(backend)/src/collector/main.go 

backend_packages_get:
	go get -d -u -v github.com/lib/pq

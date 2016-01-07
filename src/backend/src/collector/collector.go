package main

import (
	//"bufio"
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	//"io/ioutil"
	//"log"
	//"os"
	"pgpass"
	//"time"
)

type Config struct {
	Pgpass *pgpass.Pgpass
}

// conectionString ...
func ConectionString(pgpass *pgpass.Pgpass) string {
	return "host" + pgpass.Host +
		"port" + pgpass.Port +
		"user + " + pgpass.Username +
		"password" + pgpass.Password
}

// readConfig ...
func ReadConfig() *Config {
	c := new(Config)
	p := new(pgpass.Pgpass)
	p.Host = "localhost"
	p.Port = "5432"
	p.Database = "lyncspydb"
	p.Username = "lyncspy"
	c.Pgpass = p
	return c
}

// main ...
func main() {
	c := ReadConfig()
	pgpass.Read(c.Pgpass)
	fmt.Println(c.Pgpass)

	db, err := sql.Open("postgres",
		"user=lyncspy dbname=lyncspydb host=localhost "+
			"port=5432 password=lyncspy_")
	if err != nil {
		panic(err)
		//fmt.Println("Error: The data source arguments are not valid")
	}

	err = db.Ping()
	if err != nil {
		//panic(err)
		fmt.Println("Error: Could not establish a connection with the database")
	}
}

//fix state()
//{
//	select statusid from state order by changedate limit 1;
//	if(row == 0) insert into state ( invalid )
//	else update statusid = invalid...
//}
//
//update state()
//{
//	if(select from stateid from )....
//}

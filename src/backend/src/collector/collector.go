package main

import (
	"database/sql"

	//"bufio"
	"fmt"
	//_ "github.com/BurntSushi/toml"
	"collector/configManager"
	_ "github.com/lib/pq"
	//"io/ioutil"
	//"errors"
	//"log"
	//"os"
	//"pgpass"
	//"strings"
	//"time"
)

// conectionString ...
func ConectionString(pgpass *configManager.Pgpass) string {
	return "host=" + pgpass.Host +
		"port=" + pgpass.Port +
		"user=" + pgpass.Username +
		"password=" + pgpass.Password
}

// main ...
func main() {

	c, err := configManager.ReadConfig()
	if err != nil {
		panic(err)
	}
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

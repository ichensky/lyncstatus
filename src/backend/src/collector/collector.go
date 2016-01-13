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
	"log"
	//"os"
	//"pgpass"
	//"strings"
	//"time"
)

// checkerr( ...
func checkerr(err error) {
	if err != nil {
		panic(err)
	}
}

// main ...
func main() {

	c, err := configManager.ReadDbConfig("db.cfg")
	checkerr(err)
	fmt.Println(c.Pgpass)

	connectionString := configManager.ConectionString(c.Pgpass)
	fmt.Println(connectionString)

	db, err := sql.Open("postgres", connectionString)
	if err != nil {
		log.Fatal("Error: The data source arguments are not valid")
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatal("Error: Could not establish a connection with the database")
	}

	rows, err := db.Query("select * from status")
	checkerr(err)
	fmt.Println(rows.Columns())

	var id int
	var name string
	var description string
	for rows.Next() {

		err = rows.Scan(&id, &name, &description)
		checkerr(err)
		fmt.Printf("%3v %15v %45v\n", id, name, description)
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

package main

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	//"time"
)

// main ...
func main() {
	fmt.Println("Hello")
	db, err := sql.Open("postgres", "user=lyncspy dbname=lyncspydb sslmode=disable")
	if err != nil {
		fmt.Println("Error: The data source arguments are not valid")
	}

	err = db.Ping()
	if err != nil {
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

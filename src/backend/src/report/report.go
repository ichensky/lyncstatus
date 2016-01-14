package main

import (
	"database/sql"

	//"bufio"
	"fmt"
	//_ "github.com/BurntSushi/toml"
	"configManager"
	_ "github.com/gorilla/mux"
	_ "github.com/lib/pq"
	//"io/ioutil"
	//"errors"
	"log"
	//"os"
	//"pgpass"
	//"strings"
	//"time"
	"html"
	"net/http"
)

var connectionString string
var db *sql.DB

type Status struct {
	id          int
	name        string
	description string
}

//--- Erorrs

func checkerr(err error) {
	if err != nil {
		panic(err)
	}
}

// ---

// --- Pages

// Status ...
func statusPage(w http.ResponseWriter, r *http.Request) {
	fmt.Print("status...page")

}

func indexPage(w http.ResponseWriter, r *http.Request) {

	fmt.Fprintf(w, "<h1>Hello in LyncSpy app.</h1><br />"+
		"<p>U can see statistic here:<br /></p>")
	return
	fmt.Fprintf(w, "Hello, %q", html.EscapeString(r.URL.Path))

}

// ---

/// --- Data

// pingDb( ...
func pingDb() {

	err := db.Ping()
	if err != nil {
		log.Fatal("Error: Could not establish a connection with the database")
	}
}

func statusData() ([]Status, error) {

	rows, err := db.Query("select * from status")
	checkerr(err)
	fmt.Println(rows.Columns())

	var status []Status
	var id int
	var name string
	var description string

	for rows.Next() {

		err = rows.Scan(&id, &name, &description)
		checkerr(err)

		status = append(status, Status{id, name, description})

		//fmt.Printf("%3v %15v %45v\n", id, name, description)
	}
	return status, nil
}

/// ---

/// --- Config
func initData() {

	c, err := configManager.ReadDbConfig("db.cfg")
	checkerr(err)
	connectionString = configManager.ConectionString(c.Pgpass)
}

/// ---

/// --- Server

// StartServer( ...
func startServer() {

	log.Println("Server started at: :8080")

	http.HandleFunc("/", indexPage)
	http.HandleFunc("/", statusPage)
	log.Fatalln(http.ListenAndServe(":8080", nil))

	log.Println("Servert stoped.")

}

/// ---

// main ...
func main() {
	initData()
	var err error
	db, err = sql.Open("postgres", connectionString)
	if err != nil {
		log.Fatal("Error: The data source arguments are not valid")
	}
	defer db.Close()

	pingDb()

	var status []Status
	status, err = statusData()

	fmt.Println(&status)
	//startServer()
}

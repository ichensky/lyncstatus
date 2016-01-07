package pgpass

import (
	"bufio"
	"log"
	"os"
	//"strconv"
	"errors"
	"strings"
)

type Pgpass struct {
	Host, Port, Database, Username, Password string
}

// Parse ...
func parsePassword(str string, line string) string {
	return strings.Replace(str, line, "", 1)

}

// Read ...
func InitPassword(pgpass *Pgpass) error {
	home := os.Getenv("HOME")
	file, err := os.Open(home + "/.pgpass")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	line := pgpass.Host + ":" +
		pgpass.Port + ":" +
		pgpass.Database + ":" +
		pgpass.Username + ":"
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		str := scanner.Text()
		index := strings.Index(str, line)
		if index == 0 {
			pgpass.Password = parsePassword(str, line)
			break
		}
		return errors.New("pgpass: Entity not present in file: " +
			file.Name())
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	return nil
}

package configManager

import (
	"bufio"
	"fmt"
	//_ "github.com/BurntSushi/toml"
	//"io/ioutil"
	"errors"
	//"log"
	"os"
	//"pgpass"
	"strings"
	//"time"
)

type Pgpass struct {
	Host, Port, Database, Username, Password string
}

type Config struct {
	pgpass string
	Pgpass *Pgpass
}

func somefunc() {
	fmt.Println("Hello")
}

func readPasswordFromPgpass(line string) (string, error) {
	home := os.Getenv("HOME")
	file, err := os.Open(home + "/.pgpass")
	if err != nil {
		return "", err
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		str := scanner.Text()
		index := strings.Index(str, line)
		if index == 0 {
			return str[len(line):], nil
		}
		return "", errors.New("pgpass: Entity not present in file: " +
			file.Name())
	}

	return "", scanner.Err()
}
func readConfigPgpass(str string) (*Pgpass, error) {
	s := strings.Split(str, ":")
	if len(s) != 5 {
		return nil, errors.New("Config value `pgpass` is not valid.")
	}

	password, err := readPasswordFromPgpass(str)
	if err != nil {
		return nil, err
	}

	p := Pgpass{s[0], s[1], s[2], s[3], password}

	return &p, nil
}

// readConfig ...
func ReadConfig(filename string) (*Config, error) {
	c := new(Config)

	file, err := os.Open("../etc/usr" + filename)
	if os.IsNotExist(err) {
		file, err = os.Open("../etc/" + filename)
	}

	if err != nil {
		return nil, err
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		str := scanner.Text()
		key := "pgpass="
		index := strings.Index(str, key)
		if index == -1 {
			return nil, errors.New("Config file doesn't contains: " + key)
		} else if index == 0 {
			value := str[len(key):]
			pgpass, err := readConfigPgpass(value)
			if err != nil {
				return nil, err
			}
			c.Pgpass = pgpass

		}
	}

	return c, scanner.Err()
}

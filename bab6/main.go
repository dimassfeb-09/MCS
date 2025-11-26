package main

import (
	"database/sql"
	"fmt"
	"log"
	"mcs_bab_6/database"
	"mcs_bab_6/routers"

	_ "github.com/lib/pq"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = "postgres"            // SESUAIKAN DENGAN PASSWORD POSTGRE YANG TELAH DIDAFTARKAN
	dbName   = "praktikum_mcs_bab_6" // SESUAIKAN DENGAN NAMA DATABASE YANG DIBUAT
)

var (
	DB  *sql.DB
	err error
)

func main() {
	var PORT = ":8080"

	psqlInfo := fmt.Sprintf(
		`host=%s port=%d user=%s password=%s dbname=%s sslmode=disable`,
		host, port, user, password, dbName,
	)

	DB, err = sql.Open("postgres", psqlInfo)

	if err != nil {
		log.Fatal("Error Open DB: ", err)
	}

	database.DBMigrate(DB)

	defer DB.Close()

	if routers.StartServer().Run(PORT); err != nil {
		fmt.Println("ERROR", err.Error())
	}
	fmt.Printf("Success Connected")
}

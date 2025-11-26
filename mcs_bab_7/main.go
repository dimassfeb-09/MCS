package main

import (
	"database/sql"
	"fmt"
	"log"
	"mcs_bab_7/database"
	"mcs_bab_7/routers"

	_ "github.com/lib/pq"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = "123456"              // SESUAIKAN DENGAN PASSWORD POSTGRE YANG TELAH DIDAFTARKAN
	dbName   = "praktikum_mcs_bab_7" // SESUAIKAN DENGAN NAMA DATABASE YANG DIBUAT
)

var (
	DB  *sql.DB
	err error
)

func main() {
	var PORT = ":49153"

	psqlInfo := fmt.Sprintf(
		`host=%s port=%d user=%s password=%s dbname=%s sslmode=disable`,
		host, port, user, password, dbName,
	)

	DB, err = sql.Open("postgres", psqlInfo)

	if err != nil {
		log.Fatal("Error open DB", psqlInfo)
	}

	database.DBMigrate(DB)

	defer DB.Close()

	routers.StartServer().Run(PORT)
	fmt.Println("DB Success Connected")
}

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
	password = "postgres"
	dbName   = "traning_mcs_bab_6"
)

var (
	DB  *sql.DB
	err error
)

func main() {
	var PORT = ":50000"

	psqlInfo := fmt.Sprintf(
		`host=%s port=%d user=%s password=%s dbname=%s sslmode=disable`,
		host, port, user, password, dbName,
	)

	DB, err = sql.Open("postgres", psqlInfo)
	if err != nil {
		log.Fatal("Error Open DB: ", err)
	}

	// 🔥 Tambahkan ini
	err = DB.Ping()
	if err != nil {
		log.Fatal("PING ERROR: ", err)
	}
	log.Println("PING OK → berhasil connect ke Postgres!")

	database.DBMigrate(DB)
	defer DB.Close()

	routers.StartServer().Run(PORT)
	fmt.Println("Success Connected")
}

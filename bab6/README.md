# Setup PostgreSQL dengan Docker & Konfigurasi Go

Dokumen ini berisi langkah-langkah lengkap untuk menjalankan PostgreSQL
menggunakan Docker serta menghubungkannya dengan aplikasi Go.

------------------------------------------------------------------------

## 1. Pastikan Docker Sudah Terpasang

Cek apakah Docker sudah terinstall dengan menjalankan perintah berikut:

``` bash
docker --version
```

Jika muncul versi Docker, berarti instalasi berhasil.

------------------------------------------------------------------------

## 2. Jalankan PostgreSQL Menggunakan Docker (Jika Belum)

Gunakan perintah berikut untuk membuat container PostgreSQL (versi 16):

``` bash
docker run -d --name postgres ^
  -e POSTGRES_USER=postgres ^
  -e POSTGRES_PASSWORD=postgres ^
  -p 5432:5432 ^
  -v postgres_data:/var/lib/postgresql/data ^
  postgres:16
```

**Keterangan:**

-   **Username**: postgres
-   **Password**: postgres
-   **Port**: 5432

------------------------------------------------------------------------

## 3. Salin Folder dan Kode Project

Pastikan kamu sudah menyalin folder project Go (`bab_6`).

------------------------------------------------------------------------

## 4. Inisialisasi Go Module

Masuk ke folder project, lalu jalankan:

``` bash
go mod init mcs_bab_6
go mod tidy
```

------------------------------------------------------------------------

## 5. Konfigurasi Database di `main.go`

Gunakan konfigurasi berikut:

``` go
const (
    host     = "localhost"
    port     = 5432
    user     = "postgres"
    password = "postgres"
    dbName   = "traning_mcs_bab_6"
)
```

Pastikan database `traning_mcs_bab_6` sudah dibuat.

------------------------------------------------------------------------

## 6. Jalankan Aplikasi

Gunakan perintah:

``` bash
go run ./main.go
```

Jika berhasil, aplikasi akan terhubung ke PostgreSQL dan server berjalan
dengan baik.

------------------------------------------------------------------------

## Selesai 🎉

Database sudah berjalan di Docker, dan aplikasi Go sudah terhubung ke
PostgreSQL.

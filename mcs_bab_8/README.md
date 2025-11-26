# **PRAKTIKUM MCS BAB 8**

## _CARD READER_ & _SERVO CONTROLLER_
***
Pada praktikum MCS bab 8, praktikan akan membangun sebuah aplikasi yang dapat mengontrol servo dan melihat data id kartu yang masuk ke database melalui sensor Radio Frequency Identification (RFID). Agar dapat mengontrol servo dan membaca id kartu yang masuk, kita akan mengonsumsi data API yang telah dibuat pada pertemuan praktikum bab 6 dan bab 7.

### **8.1 TUJUAN PRAKTIKUM**
| Tujuan | Penjelasan |
| --------- | ------------- |
| Mengetahui cara mengontrol servo menggunakan kartu RFID | Pada bab ini, praktikan akan dijelaskan mengenai bagaimana cara untuk menggerakan servo menggunakan kartu RFID |
| Memahami cara memasangkan id kartu dengan database | Bab ini akan menggunakan kartu RFID yang di daftarkan ke database untuk memantau perubahan kondisi servo |
***

### **8.2 PERSYARATAN PRAKTIKUM**
Disarankan praktikan menggunakan hardware dan software sesuai pada dokumentasi ini. Apabila terdapat versi yang lumayan lampau dari versi yang direkomendasikan atau hardware yang lawas maka sebaiknya bertanya kepada Asisten mengajar shift.

| HARDWARE YANG DIBUTUHKAN | JENIS |
| --------- | ------------- |
| PC / LAPTOP CPU | ≥ 4 CORES |
| PC / LAPTOP RAM | ≥ 8 GB |
| PC / LAPTOP STORAGE | ≥ 10 GB |
<br>

| SOFTWARE YANG DIBUTUHKAN | |
| --------- | ------------- |
| Android Studio / Visual Studio Code |
| Arduino IDE|
| Postman |
***

### **8.3 MATERI PRAKTIKUM**
Pada pertemuan sebelumnya, kita telah membuat 2 database dengan beberapa route endpoint. Database dan endpoint yang dibuat pada bab 6 merupakan endpoint untuk menangani proses pembacaan data kartu yang masuk ke database melalui RFID. Sedangkan, database dan endpoint pada bab 7 digunakan untuk mengontrol servo.
* _Endpoint_ yang digunakan pada bab 6

| Endpoint | Penggunaan |
| -------- | ---------- |
| /cards | Digunakan untuk menampilkan seluruh data yang ada dengan method API yang digunakan adalah method GET. |
| /card/input/:id | Digunakan untuk menginput data baru ke dalam database dengan method API yang digunakan adalah method POST. Untuk menginput data, variabel id pada endpoint diganti dengan data yang diinginkan. |
| /card/delete/:id | Digunakan untuk menghapus data yang telah tersimpan dalam database dengan menggunakan method API DELETE. Sama halnya dengan pada saat input data, variabel id pada endpoint tersebut juga diganti dengan data yang ingin dihapus. |

* _Endpoint_ yang digunakan pada bab 7

| Endpoint | Penggunaan |
| -------- | ---------- |
| /servo/init-proj | Digunakan untuk menginisialisasi data awal dengan method API yang digunakan adalah method POST |
| /servo/status | Digunakan untuk menampilkan seluruh data yang ada dengan menggunakan methodm GET. |
| /servo/update/:srv_status | Digunakan untuk mengupdate data dari servo status dengan menggunakan method API PUT. Untuk mengupdate data, variabel srv_status pada endpoint diganti dengan data yang diinginkan |
***

### **8.4 PROSEDUR PRAKTIKUM**
### **8.4.1 Tampilan Aplikasi**
Berikut merupakan tampilan dari aplikasi yang akan dibentuk pada praktikum bab 8.
<div align="center">
  <img width="292" height="593" alt="image" src="https://github.com/user-attachments/assets/da71182a-2d84-470d-bd56-19dae807acad" />
</div> <br>

**Penjelasan terkait bagaimana cara aplikasi bekerja akan diterangkan oleh asisten yang mengajar.**

### **8.4.2 Implementasi Aplikasi**
Implementasi aplikasi dilakukan dalam 2 lingkup berbeda, yakni lingkup pembangunan tampilan aplikasi menggunakan Flutter dan lingkup konfigurasi terhadap sensor yang digunakan. Sensor yang digunakan pada praktikum ini, antara lain servo dan RFID.
### **8.4.2.1 Pembuatan Aplikasi**
Dalam mengimplementasikan tampilan dari desain aplikasi di atas, terdapat beberapa langkah yang harus dilewati terlebih dahulu agar proses praktikum dapat berjalan dengan lancar dan terselesaikan sesuai dengan apa yang dituju. Langkah-langlah dalam pembuatan project baru sama seperti yang telah dilakukan pada praktikum pertemuan sebelumnya.
<div align="center">
  <img width="827" height="392" alt="image" src="https://github.com/user-attachments/assets/ad32bbba-4a26-4e19-aeab-e5926ebdcd73" />
</div> <br>

<div align="center">
  <img width="589" height="538" alt="image" src="https://github.com/user-attachments/assets/f63c0715-e5a3-42af-b48a-e432444064df" />
</div> <br>

Setelah project berhasil terbentuk masuklah ke dalam file pubspec.yaml dan tambahkan package provider dan dio. Ketika sudah menambahkan kedua package tersebut jangan lupa untuk di pub get agar package yang ditambahkan dapat digunakan.
<div align="center">
  <img width="827" height="373" alt="image" src="https://github.com/user-attachments/assets/5cc603c2-c512-4861-9628-df564c5f8654" />
</div> <br>

Setelah melakukan pub get, buatlah struktur tree project, seperti yang terlihat pada Gambar
<div align="center">
  <img width="373" height="480" alt="image" src="https://github.com/user-attachments/assets/5ca8cac9-de9b-4a6f-9ab5-709bbc86d38d" />
</div> <br>

Berikutnya ketika struktur tree project sudah tersusun seperti pada gambar, masuklah ke dalam file card_bridge_model.dart dan isikan kode program berikut:
```dart
CardBridgeModel cardBridgeModelFromJson(String str) => CardBridgeModel.fromJson(json.decode(str));
String cardBridgeModelToJson(CardBridgeModel data) => json.encode(data.toJson());

class CardBridgeModel {
  List<Result> result;
  CardBridgeModel({
    required this.result,
  });

  factory CardBridgeModel.fromJson(Map<String, dynamic> json) => CardBridgeModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String id;
  Result({
    required this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
```

Setelah file tersebut terisikan dengan kode program yang membangun model untuk mendapatkan data API yang dikirimkan melalui RFID, langkah berikutnya adalah membangun model yang akan digunakan untuk mengambil data yang dikirimkan oleh servo. Kode program tersebut dibentuk pada file servo_status_model.dart.
```dart
ServoStatusModel servoStatusModelFromJson(String str) => ServoStatusModel.fromJson(json.decode(str));

String servoStatusModelToJson(ServoStatusModel data) => json.encode(data.toJson());

class ServoStatusModel {
  List<Result> result;
  ServoStatusModel({
    required this.result,
  });

  factory ServoStatusModel.fromJson(Map<String, dynamic> json) => ServoStatusModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  int srvStatus;

  Result({
    required this.id,
    required this.srvStatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    srvStatus: json["srv_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "srv_status": srvStatus,
  };
}
```

Setelah membuat kedua model object dart berdasarkan response API yang diberikan, langkah berikutnya adalah melakukan penulisan kode untuk file card_api_service.dart dan servo_status_service.dart. Berikut merupakan kode yang digunakan untuk membangun service API dari card_bridge_model.dart
```dart
class CardApiService {
  Dio dio = Dio();
  String cardBridgeUrl = "https://<ip_address>:<PORT>";

  Future<CardBridgeModel> getUid() async {
    try {
      final response = await dio.get("$cardBridgeUrl/cards");
      return CardBridgeModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future deleteCard({required String idCard}) async {
    try {
      final response = await dio.delete("$cardBridgeUrl/card/delete/$idCard");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
```

Kode program tersebut digunakan untuk menghandle bagian RFID. Pada bagian awal class tersebut, didefinisikan variabel cardBridgeUrl yang berisikan url yang tersusun dari ip address dan port yang telah ditentukan. Kemudian, terdapat 2 fungsi yang didefinisikan, yakni fungsi getUid() yang digunakan untuk membaca data id kartu yang tersimpan di dalam database dan fungsi deleteCard() yang digunakan untuk menghapus data id kartu dari database.

Selanjutnya masuklah ke dalam file servo_api_status.dart dan tuliskan kode program berikut:
```dart
class ServoApiService {
  Dio dio = Dio();
  String servoControllerUrl = "https://<ip_address>:<PORT>";

  Future<ServoStatusModel> getServoStatus() async{
    try{
      final response = await dio.get("$servoControllerUrl/servo/status");
      return ServoStatusModel.fromJson(response.data);
    }catch(e){
      rethrow;
    }
  }
  writeServoStatus({required String status}) async {
    try{
      final response =  await dio.put("$servoControllerUrl/servo/update/$status");
      return response.data;
    }catch(e){
      rethrow;
    }
  }
}
```

Kode program tersebut digunakan untuk menghandle bagian servo. Pada bagian awal class tersebut, didefinisikan variabel servoControllerUrl yang berisikan url yang tersusun dari ip address dan port yang telah ditentukan. Kemudian, terdapat 2 fungsi yang didefinisikan, yakni fungsi getServoStatus() yang digunakan untuk membaca status dari servo dan fungsi writeServoStatus() yang digunakan untuk menggerakan servo.

Kemudian masuklah ke dalam file app_provider.dart dan tuliskan kode program berikut ke file tersebut:
```dart
class AppProvider extends ChangeNotifier{
  ServoStatusModel? servoStatusModel;
  CardBridgeModel? cardBridgeModel;
  String servoStatus = "";
  String textLeftButton = "Set Servo to 0";
  String textRightButton= "Set Servo to 1";
  Color colorLeftButton = const Color(0xffFF6500);
  Color colorRightButton = const Color(0xff1E3E62);

  Stream getServoStatus() async*{
    while(true){
      yield servoStatusModel = await ServoApiService().getServoStatus();
      await Future.delayed(const Duration(seconds: 1));
      notifyListeners();
    }
  }

  Future changeServoStatus({required String status}) async{
    await ServoApiService().writeServoStatus(status: status);
    notifyListeners();
  }

  Stream getUid() async*{
    while(true){
      yield cardBridgeModel = await CardApiService().getUid();
      await Future.delayed(const Duration(seconds: 2));
      notifyListeners();
    }
  }

  Future deleteUid({required String uid}) async{
    await CardApiService().deleteCard(idCard: uid);
    notifyListeners();
  }
}
```

Kode program tersebut akan menginisialisasi seluruh atribut, seperti variabel dan fungs yang diperlukan ke dlaam 1 file. Sehingga, kita dapat menggunakannya secara berulang tanpa harus mendefinisikan dari awal. Berikutnya masuklah ke dalam file main.dart dan isikan dengan kode program berikut:
```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'MCS BAB 8,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
```

Pada file main.dart terlihat bahwa terdapat pemanggilan terhadap class AppProvider() yang bertujuan agar seluruh variabel dan fungsi yang telah didefinisikan pada provider dapat langsung dijalankan bersamaan pada saat aplikasi dijalankan. Selanjutnya, kita akan membuat sebuah class yang di dalamnya berisikan kode program yang akan membangun suatu tombol yang akan digunakan untuk mengontrol servo. Masuklah ke dlaam file custom_servo_button.dart dan masukkan kode program berikut:
```dart
class CustomServoButton extends StatelessWidget {
  String textLeftButton;
  String textRightButton;
  Color colorLeftButton;
  Color colorRightButton;
  Function() onTapLeftButton;
  Function() onTapRightButton;

  CustomServoButton({
    super.key,
    required this.textLeftButton,
    required this.textRightButton,
    required this.colorLeftButton,
    required this.colorRightButton,
    required this.onTapLeftButton,
    required this.onTapRightButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            backgroundColor: colorLeftButton,
          ),
          child: Text(
            textLeftButton,
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            onTapLeftButton();
          },
        ),

        const SizedBox(width: 20),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            backgroundColor: colorRightButton,
          ),
          child: Text(
            textRightButton,
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            onTapRightButton();
          },
        ),
      ],
    );
  }
}
```

Class CustomServoButton() merupakan sebuah class yang akan membentuk tampilan button yang akan mengotrol servo. Di dalam class tersebut terdapat constructor untuk kebutuhan tampilan buttonnya ataupun proses bisnisnya. Constructor ini akan diisi ketika class ServoButton() dipanggil.

Setelah proses pembuatan button selesai dilakukan, bukalah file home_page.dart dan masukkan kode program berikut:
```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).getUid();
    Provider.of<AppProvider>(context, listen: false).getServoStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Flutter Servo & Cards Control',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xff0B192C),
          ),
          body: Column(
            children: [
              const SizedBox(height: 50),

              CustomServoButton(
                textLeftButton: appProvider.textLeftButton,
                textRightButton: appProvider.textRightButton,
                colorLeftButton: appProvider.colorLeftButton,
                colorRightButton: appProvider.colorRightButton,
                onTapLeftButton: () =>
                    appProvider.changeServoStatus(status: "0"),
                onTapRightButton: () =>
                    appProvider.changeServoStatus(status: "1"),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Text("Servo Status : ", style: const TextStyle(fontSize: 20)),
                  StreamBuilder(
                    stream: appProvider.getServoStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("-");
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error => ${snapshot.error}"),
                        );
                      } else {
                        appProvider.servoStatus = appProvider
                            .servoStatusModel!
                            .result[0]
                            .srvStatus
                            .toString();
                        return Text(appProvider.servoStatus);
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 3, color: Colors.black),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: const Column(
                  children: [SizedBox(height: 30), Text("Card ID Register:")],
                ),
              ),

              Expanded(
                child: StreamBuilder(
                  stream: appProvider.getUid(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error to get ID: ${snapshot.error}"),
                      );
                    } else if (snapshot.data == null || !snapshot.hasData) {
                      return const Center(child: Text("No data to display"));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: appProvider.cardBridgeModel!.result.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appProvider.cardBridgeModel!.result[index].id,
                                ),
                                GestureDetector(
                                  child: const Icon(Icons.delete),
                                  onTap: () {
                                    appProvider.deleteUid(
                                      uid: appProvider
                                          .cardBridgeModel!
                                          .result[index]
                                          .id,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

Pada kode program tersebut, terdapat widget StreamBuilder() yang digunakan. Widget tersebut umumnya digunakan ketika kita ingin membuat sebuah aplikasi yang menampilkan data secara real time. Penggunaan StreamBuilder() digunakan dalam 2 kondisi, yakni kondisi untuk menghandle status servo dan kondisi untuk menghandle data id kartu. 
```dart
return Consumer<AppProvider>(
  builder: (context, appProvider, child) {
    return Scaffold(
      appBar: AppBar(
        // ...
      ),
      body: Column(
        children: [

          // ...

          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: appProvider.getServoStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              "Error to get servo status: ${snapshot.error}",
                            ),
                          ),
                        );
                      } else {
                        appProvider.servoStatus = appProvider
                            .servoStatusModel!
                            .result[0]
                            .srvStatus
                            .toString();
                        return Text(
                          "Servo Status: ${appProvider.servoStatus}",
                          style: const TextStyle(fontSize: 20),
                        );
                      }
                    },
                  ),
                ],
              ),

          // ...
          
        ],
      ),
    );
  },
);
```

Kode di atas merupakan kode yang akan menghandle status dari servo. Widget StreamBuilder() pada kode tersebut akan melakukan stream atau pemantauan secara langsung terhadap fungsi getStatusServo() yang telah didefinisikan pada provider. Terdapat beberapa kondisi yang akan ditampilkan, bergantung kepada proses apa yang sedang dijalankan. Jika proses pengambilan data masih berlangsung, maka aplikasi akan menampilkan text “-”. Jika setelah pengambilan data ditemukan error, maka aplikasi akan menampilkan pesan error. Namun, jika aplikasi berhasil mengambil data, maka aplikasi akan menampilkan data berupa status dari servo tersebut.
```dart
return Consumer<AppProvider>(
  builder: (context, appProvider, child) {
    return Scaffold(
      appBar: AppBar(
        // ...
      ),
      body: Column(
        children: [
          // ...

          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 3, color: Colors.black),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: const Column(
              children: [SizedBox(height: 30), Text("Card ID Register:")],
            ),
          ),

          Expanded(
                child: StreamBuilder(
                  stream: appProvider.getUid(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error to get ID: ${snapshot.error}"),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: appProvider.cardBridgeModel!.result.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appProvider.cardBridgeModel!.result[index].id,
                                ),
                                GestureDetector(
                                  child: const Icon(Icons.delete),
                                  onTap: () {
                                    appProvider.deleteUid(
                                      uid: appProvider
                                          .cardBridgeModel!
                                          .result[index]
                                          .id,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
        ],
      ),
    );
  },
);
```

Kode di atas merupakan kode yang akan menghandle data id kartu.  Sama seperti kode program sebelumnya, kode program ini akan melakukan stream terhadap fungsi getUid() yang telah didefinisikan dan akan menghasilkan tampilan yang berbeda-beda berdasarkan kondisi yang sedang dilewati. Jika proses pengambilan data masih berlangsung, maka aplikasi akan animasi loading yang berada di bagian tengah. Jika setelah pengambilan data ditemukan error, maka aplikasi akan menampilkan pesan error. Jika, data tersebut beesifat null atau data response kosong, maka aplikasi akan menampilkan pesan bahwa data id tidak tersedia. Namun, jika aplikasi berhasil mengambil data, maka aplikasi akan menampilkan seluruh id card yang terdaftar.

<br>

### **8.4.2.2 Konfigurasi Alat**
Setelah proses pembangunan aplikasi selesai dilakukan, maka kita dapat berpindah pada proses konfigurasi sensor-sensornya. Praktikum memanfaatkan ESP32, RFID-RC522, dan Servo Motor untuk membaca tag RFID dan mengontrol servo berdasarkan instruksi dari server melalui HTTP request. Dengan memanfaatkan koneksi Wi-Fi, sistem ini memungkinkan komunikasi realtime dengan server, yang dapat digunakan untuk aplikasi seperti kontrol akses atau otomatisasi berbasis RFID.
<div align="center">
  <img width="552" height="392" alt="image" src="https://github.com/user-attachments/assets/68257bc9-5188-4c10-a8c9-8c4ae7f7a488" />
</div> <br>

Bukalah software Arduino IDE yang telah terinstall pada platform anda dan lakukanlah instalasi terhadap package ESP-32 dengan mengikut langkah-langkah berikut.
<div align="center">
  <img width="827" height="465" alt="image" src="https://github.com/user-attachments/assets/86ec543e-02d9-4b2e-b1c2-6b6e5f69f724" />
</div> <br>

1. Bukalah software Arduino IDE yang telah terinstall
2. Bukalah menu File lalu pergi ke menu preferences
3. Tambahkan URL berikut pada bagian Additional Boards Manager URLs:
```
https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
```

<div align="center">
  <img width="827" height="515" alt="image" src="https://github.com/user-attachments/assets/c1099c1b-8a8f-486c-81eb-4c5a8c2e473e" />
</div> <br>

<div align="center">
  <img width="827" height="465" alt="image" src="https://github.com/user-attachments/assets/08e17ba5-5a95-4f61-a18e-4d8181e4bf93" />
</div> <br>

<div align="center">
  <img width="590" height="319" alt="image" src="https://github.com/user-attachments/assets/5388d83e-c1e9-418e-bbde-e746ce7a5285" />
  <p style="text-align:center;">Skematik Rangkaian</p>
</div> <br>

<div align="center">
  <img width="584" height="296" alt="image" src="https://github.com/user-attachments/assets/1ca18392-3dc7-4d37-94bd-5a215214e03a" />
  <p style="text-align:center;">Pin Servo dan ESP-32</p>
</div> <br>

Setelah proses wiring selesai dilakukan, kembalilah ke software Arduino IDE dan masukan kode program berikut:
```C++
#include <WiFi.h>
#include <HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h>
#include <ESP32Servo.h>

#define SS_PIN  5    // ESP32 pin GPIO5 
#define RST_PIN 27   // ESP32 pin GPIO27 

const char* ssid = "";       // SESUAIKAN DENGAN SSID Wi-Fi YANG TERHUBUNG
const char* password = ""; // SESUAIKAN DENGAN PASSWORD Wi-Fi YANG TERHUBUNG

const char* serverURL = "http://<IP ADDRESS>:<PORT>/servo/status";

MFRC522 rfid(SS_PIN, RST_PIN);
Servo myServo;

void setup() {
  Serial.begin(115200);
  myServo.attach(12);

  WiFi.begin(ssid, password); // CONNECT TO Wi-Fi
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("Connected to WiFi");

  SPI.begin();           // INITIALIZE SPI BUD
  rfid.PCD_Init();       // INITIALIZE MFRC522

  Serial.println("Tap an RFID/NFC tag on the RFID-RC522 reader");
}

void loop() {
  // Check for RFID tag
  if (rfid.PICC_IsNewCardPresent()) {
    if (rfid.PICC_ReadCardSerial()) {
      MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
      Serial.print("RFID/NFC Tag Type: ");
      Serial.println(rfid.PICC_GetTypeName(piccType));

      // PRINT UID IN SERIAL MONITOR IN HEX FORMAT
      String uidStr = "";
      Serial.print("UID:");
      for (int i = 0; i < rfid.uid.size; i++) {
        Serial.print(rfid.uid.uidByte[i] < 0x10 ? " 0" : " ");
        Serial.print(rfid.uid.uidByte[i], HEX);
        uidStr += String(rfid.uid.uidByte[i], HEX);
      }
      Serial.println();

      // SEND UID TO SERVER
      sendUIDToServer(uidStr);

      rfid.PICC_HaltA();        // HALT PICC
      rfid.PCD_StopCrypto1();   // STOP ENCRYPTION ON PCD
    }
  }
  checkServoStatus();
  delay(200);
}

void sendUIDToServer(String uid) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    String url = "http://<IP ADDRESS>:<PORT>/card/input/" + uid;  // SESUAIKAN DENGAN IP DAN PORT
    http.begin(url);

    int httpResponseCode = http.POST("");

    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println("Server Response: " + response);
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end();
  } else {
    Serial.println("WiFi not connected");
  }
}

// FUNCTION UNTUK STATUS SERVO
void checkServoStatus() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(serverURL);
    
    int httpResponseCode = http.GET();
    
    if (httpResponseCode > 0) {
      String payload = http.getString();
      Serial.println("HTTP Response: " + payload);
      
     // Parse JSON response
      if (payload.indexOf("\"srv_status\":1") != -1) {
        // JIKA srv_status BERNILAI 1, SERVO AKAN BERGERAK KE CCW
        Serial.println("Servo moving to CCW");
        myServo.write(0);
      } else if (payload.indexOf("\"srv_status\":0") != -1) {
        // JIKA srv_status BERNILAI 0, SERVO AKAN BERGERAK KE CW
        Serial.println("Servo moving to CW");
        myServo.write(180);
      } else {
        Serial.println("Unknown status received");
      }
    } else {
      Serial.println("Error on HTTP request");
    }
    http.end();
  } else {
    Serial.println("WiFi Disconnected");
  }
}
```

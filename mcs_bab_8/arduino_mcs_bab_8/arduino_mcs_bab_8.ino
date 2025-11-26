#include <WiFi.h>
#include <HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h>
#include <ESP32Servo.h>

#define SS_PIN  5    // ESP32 pin GPIO5 
#define RST_PIN 27   // ESP32 pin GPIO27 

const char* ssid = "UGMURO-INET";       // SESUAIKAN DENGAN SSID Wi-Fi YANG TERHUBUNG
const char* password = "Gepuk15000"; // SESUAIKAN DENGAN PASSWORD Wi-Fi YANG TERHUBUNG

const char* serverURL = "http://192.168.100.134:49153/servo/status";

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
  delay(2000);
}

void sendUIDToServer(String uid) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    String url = "http://192.168.100.134:49152/card/input/" + uid;  // SESUAIKAN DENGAN IP DAN PORT
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
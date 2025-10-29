# **PRAKTIKUM MCS BAB 3**

## 🧩 **Panduan Instalasi Firebase + Flutter (FlutterFire)**

### ⚙️ 1. **Buat Project Flutter Baru**
```bash
flutter create mcs_bab_3
cd mcs_bab_3
```

---

### 📁 2. **Salin Folder Project**
Salin folder berikut dari repositori praktikum:
- `lib/`
- `assets/`
- `pubspec.yaml`
- `firebase_options.dart` (akan dibuat otomatis nanti)

---

### 🔧 3. **Install Firebase Tools (CLI)**
Pastikan sudah install Node.js terlebih dahulu, lalu jalankan:
```bash
npm install -g firebase-tools
```

Login ke akun Firebase:
```bash
firebase login
```

Cek daftar project Firebase kamu:
```bash
firebase projects:list
```

---

### 📦 4. **Install Dependencies Flutter**
```bash
flutter pub get
```

---

### 🧠 5. **Aktifkan FlutterFire CLI**
Untuk menghubungkan Flutter dengan Firebase:
```bash
dart pub global activate flutterfire_cli
```

Cek versi FlutterFire CLI:
```bash
flutterfire --version
```

Jika belum terdeteksi, tambahkan path secara manual:
- **macOS/Linux**
  ```bash
  export PATH="$PATH":"$HOME/.pub-cache/bin"
  ```
- **Windows**
  ```bash
  setx PATH "%PATH%;%USERPROFILE%\AppData\Local\Pub\Cache\bin"
  ```

---

### 🔥 6. **Konfigurasi Project Firebase**
Jalankan perintah berikut:
```bash
flutterfire configure
```

Langkah-langkah konfigurasi:
1. Pilih project Firebase yang sudah dibuat di console.
2. Pilih platform (Android, iOS, Web, dll).
3. Tunggu hingga selesai.

Setelah selesai, file berikut akan otomatis dibuat:
```
lib/firebase_options.dart
```

---

### 📱 7. **Tambahkan Firebase ke Aplikasi**
Pastikan `main.dart` memiliki kode berikut:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      Firebase.app();
    }
  } catch (e) {
    debugPrint("Firebase already initialized: $e");
  }

  runApp(const MyApp());
}
```


---

### 🧱 8. **Tambahkan Plugin Firebase di pubspec.yaml**
Contoh konfigurasi minimum:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core:
  firebase_auth:
  provider:
  lottie:
  google_fonts:
```

Lalu jalankan:
```bash
flutter pub get
```

---

### 🧹 9. **Build dan Jalankan Project**
```bash
flutter clean
flutter pub get
flutter run
```

---

### ✅ **Checklist Berhasil**
Jika berhasil, terminal akan menampilkan pesan:
```
Firebase has been successfully configured.
```
Dan aplikasi dapat melakukan login/logout tanpa error `[core/duplicate-app]`.

---

📌 **Catatan Tambahan**
- Gunakan **channel stable** Flutter (`flutter channel stable`).
- Hindari inisialisasi Firebase lebih dari satu kali.
- Lakukan **restart penuh** setelah menjalankan `flutterfire configure`.

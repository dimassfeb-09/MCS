import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';

class AppProvider extends ChangeNotifier {
  // INISIALISASI VARIABEL
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  // Pastikan pakai instance dari Firebase yang sudah ada
  final firebaseAuthentication = FirebaseAuth.instanceFor(app: Firebase.app());

  bool visibilityIcon = true;
  final String hintUsernameText = "Enter your mail";
  final String hintPassText = "Password";
  final String loginButtonText = "Login";
  final Color? backgroundColor = Colors.white;
  final Color? iconColor = Colors.grey;

  final titleFontstyle = GoogleFonts.robotoCondensed(
    fontSize: 17,
    color: Colors.black,
  );
  final hintTextFontStyle = GoogleFonts.oswald(
    fontSize: 14,
    color: Colors.grey,
  );
  final buttonFontStyle = GoogleFonts.oswald(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  final universalFontStyle = GoogleFonts.oswald(
    fontSize: 14,
    color: Colors.black,
  );

  // METHOD LOGIN FIREBASE
  Future loginToApp(String email, String password) async {
    try {
      final userCredential = await firebaseAuthentication
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception("Login gagal: ${e.message}");
    }
  }

  // METHOD LOGOUT FIREBASE
  Future logoutAccount() async {
    await firebaseAuthentication.signOut();
  }

  // METHOD VALIDASI FORM
  Future validationForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      notifyListeners();
      try {
        await loginToApp(emailController.text, passController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (builder) => AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Login Failed"),
                const SizedBox(height: 10),
                LottieBuilder.asset(
                  "assets/lottie_failed_animation.json",
                  height: MediaQuery.of(context).size.width / 6,
                  width: MediaQuery.of(context).size.width / 6,
                  repeat: true,
                ),
              ],
            ),
            content: const Text(
              "Silakan masukkan email dan password yang benar.",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  // METHOD RESET FIELD FORM
  void resetForm() {
    emailController.clear();
    passController.clear();
    formKey.currentState?.reset();
    notifyListeners();
  }
}

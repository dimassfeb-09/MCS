import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'provider/app_provider.dart';
import 'screens/auth_gate_page.dart';
import 'services/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: kIsWeb
          ? DefaultFirebaseOptions.web
          : DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint(
      "✅ Firebase initialized for web: ${DefaultFirebaseOptions.web.projectId}",
    );
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
      child: MaterialApp(
        title: 'MCS BAB 3',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const AuthGatePage(),
      ),
    );
  }
}

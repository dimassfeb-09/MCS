import 'package:flutter/material.dart';
import '../provider/app_provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'login_page.dart';

class AuthGatePage extends StatelessWidget {
  const AuthGatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return StreamBuilder(
          stream: appProvider.firebaseAuthentication.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginPage();
            }
          },
        );
      },
    );
  }
}

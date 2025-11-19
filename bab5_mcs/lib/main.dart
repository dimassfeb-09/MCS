import 'package:flutter/material.dart';
import 'package:mcs_bab_5/providers/app_provider.dart';
import 'package:mcs_bab_5/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider()
            ..getTemperature()
            ..getHumidity()
            ..getSoilMoisture(),
        ),
      ],
      child: MaterialApp(
        title: 'MCS BAB 5',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

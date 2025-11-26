import 'package:flutter/material.dart';
import 'package:mcs_bab_4/provider/app_provider.dart';
import 'package:mcs_bab_4/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppProvider())],
      child: MaterialApp(
        title: "MCS BAB 4",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}

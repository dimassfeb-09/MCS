import 'package:flutter/material.dart';

class ReceiverPage extends StatelessWidget {
  final String message;
  const ReceiverPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receiver Page")),
      body: Center(
        child: Text("Message: $message", style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}

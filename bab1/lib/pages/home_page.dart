import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'receiver_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int start = 0;
  int result = 0;

  TextEditingController input1Controller = TextEditingController();
  TextEditingController input2Controller = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final Uri flutterUrl = Uri.parse("https://flutter.dev");

  // FUNCTION FOR INCREMENT
  void increment() {
    setState(() {
      start++;
    });
  }

  // FUNCTION FOR DECREMENT
  void decrement() {
    setState(() {
      start--;
      if (start <= 0) {
        start = 0;
      }
    });
  }

  // FUNCTION FOR SUM OF
  void sumOf({required int x, required int y}) {
    setState(() {
      result = x + y;
    });
  }

  // FUNCTION FOR SUBSTRACTION
  void substractionFrom({required int x, required int y}) {
    setState(() {
      result = x - y;
    });
  }

  // FUNCTION FOR RESET FIELD 1, FIELD 2, NUMBER
  void resetResult() {
    setState(() {
      input1Controller.text = "";
      input2Controller.text = "";
      result = 0;
    });
  }

  @override
  void dispose() {
    input1Controller.dispose();
    input2Controller.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff102C57),
        title: const Text("MCS BAB 1", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 32),

          /// Display counter
          Center(
            child: Text(start.toString(), style: const TextStyle(fontSize: 50)),
          ),
          const SizedBox(height: 20),

          /// Increment & Decrement buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: decrement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffE4003A),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: increment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5CB338),
                ),
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 32),

          /// Input first number
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: input1Controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: "Input First Number",
              ),
            ),
          ),
          const SizedBox(height: 24),

          /// Input second number
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: input2Controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: "Input Second Number",
              ),
            ),
          ),
          const SizedBox(height: 24),

          /// Buttons for + and -
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (input1Controller.text.isEmpty ||
                        input2Controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Input 1 dan 2 tidak boleh kosong"),
                        ),
                      );
                    } else {
                      sumOf(
                        x: int.parse(input1Controller.text),
                        y: int.parse(input2Controller.text),
                      );
                    }
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (input1Controller.text.isEmpty ||
                        input2Controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Input 1 dan 2 tidak boleh kosong"),
                        ),
                      );
                    } else {
                      substractionFrom(
                        x: int.parse(input1Controller.text),
                        y: int.parse(input2Controller.text),
                      );
                    }
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          /// Result
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Result :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "$result",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          /// Reset button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: const Icon(Icons.restart_alt),
                  onTap: resetResult,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          /// Message input + send button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: "Fill this blank...",
                    ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  child: const Icon(Icons.send),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReceiverPage(message: messageController.text),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          /// Button to go to website
          Center(
            child: GestureDetector(
              onTap: () {
                launchUrl(flutterUrl);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff7CF5FF),
                ),
                child: const Text(
                  "Go to website",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

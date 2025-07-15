import 'package:flutter/material.dart';
import 'package:flutter_discs_challenge/discs_content.dart';

import 'disc.dart';
import 'disc_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Disc? selectedDisc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 32),
            const Text(
              'Welcome to [untitled]',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Choose a disc',
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: DiscsContent(
                onDiscSelected: (disc) {
                  setState(() {
                    selectedDisc = disc;
                  });
                },
              ),
            ),
            const Text(
              'Already have an account?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  if (selectedDisc != null) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      }, pageBuilder: (context, animation, secondaryAnimation) {
                        return DiscDetails(
                          disc: selectedDisc!,
                        );
                      }),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        selectedDisc != null ? Colors.black : Colors.grey[300],
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

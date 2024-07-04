import 'package:flutter/material.dart';
import 'package:playtorium_test/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playtorium Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        
      ),
      home: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1080,
              maxHeight: 1920,
            ),
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                color: Colors.blue,
                child: const HomePage(),),
              ),
            ),
          ),
    );
  }
}

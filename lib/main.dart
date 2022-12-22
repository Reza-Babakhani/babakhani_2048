import 'package:babakhani_2048/screens/game_screen.dart';
import 'package:babakhani_2048/service/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.grey,
      ),
      home: ChangeNotifierProvider.value(
          value: Game(4), child: const GameScreen(title: '2048')),
    );
  }
}

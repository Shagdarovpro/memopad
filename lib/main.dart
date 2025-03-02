import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db/database.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    Provider(
      create: (_) => AppDatabase(),
      child: MyApp(),
      dispose: (_, db) => db.close(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}


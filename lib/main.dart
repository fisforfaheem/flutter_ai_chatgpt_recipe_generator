import 'package:flutter/material.dart';
import 'package:flutter_ai_chatgpt_recipe_generator/presentation/recipe_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic AI Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const RecipeScreen(),
    );
  }
}

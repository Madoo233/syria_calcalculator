import 'package:flutter/material.dart'; 
import 'syria_calculator.dart';

void main() async {
  runApp(AnApp());
}
class AnApp extends StatelessWidget {
  const AnApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(home: SyriaCalculator());
  }
}

import 'package:flutter/material.dart';
import 'add_card_screen.dart';

void main() => runApp(const CardReaderApp());

class CardReaderApp extends StatelessWidget {
  const CardReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card Reader',
      home: AddCardScreen(),
    );
  }
}







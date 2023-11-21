import 'package:card_reader/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'card_info_form.dart';

void main() => runApp(const CardReaderApp());

class CardReaderApp extends StatelessWidget {
  const CardReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card Reader',
      home: CardInfoForm(),
    );
  }
}







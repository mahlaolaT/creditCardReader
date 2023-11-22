import 'package:card_reader/cards.dart';
import 'package:card_reader/cards_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Box? box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CardsAdapter());
  box = await Hive.openBox<Cards>("cards");
  runApp(const CardReaderApp());
}

class CardReaderApp extends StatelessWidget {
  const CardReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card Reader',
      home: CardsScreen(),
    );
  }
}







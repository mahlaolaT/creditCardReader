import 'package:card_reader/add_card_screen.dart';
import 'package:card_reader/cards.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Cards>('cards').listenable(),
        builder: (context, Box<Cards> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Looks like you haven't added any cards yet.",
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: ListView.separated(
                itemCount: box.values.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Cards? card = box.getAt(index);
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: ListTile(
                      leading: _getCardTypeIcon(card!.cardType!),
                      title: Text(card.cardNumber.toString()),
                      subtitle: Text('Expires ${card.expiryDate}'),
                      trailing: TextButton(
                        child: const Text('REMOVE'),
                        onPressed: () => box.deleteAt(index),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return const SizedBox(height: 12);
                },
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: TextButton(
          child: const Text("ADD CARD"),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddCardScreen(),
            ),
          ),
        ),
      ),
    );
  }

  Image _getCardTypeIcon(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'mastercard':
        return Image.asset(
          "assets/images/mastercard.png",
          width: 42,
          height: 42,
        );

      case 'visa':
        return Image.asset(
          "assets/images/visa.png",
          width: 42,
          height: 42,
        );

      default:
        return Image.asset(
          "assets/images/unknown.png",
          width: 42,
          height: 42,
        );
    }
  }
}

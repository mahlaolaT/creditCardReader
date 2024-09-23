import 'package:card_reader/add_card_screen.dart';
import 'package:card_reader/bloc/card_cubit.dart';
import 'package:card_reader/card_type.dart';
import 'package:card_reader/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/card_state.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CardCubit cardCubit = context.read<CardCubit>();
    return Scaffold(
      body: BlocBuilder<CardCubit, CardState>(builder: (context, state) {
        if (state is CardSaved) {
          return Center(
            child: ListView.separated(
              itemCount: state.cards.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Cards? card = state.cards[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: ListTile(
                    leading: CardType.getCardTypeIcon(CardType.fromDisplayName(card.cardType!.toLowerCase())),
                    title: Text(card.cardNumber.toString()),
                    subtitle: Text('Expires ${card.expiryDate}'),
                    trailing: TextButton(
                      child: const Text('REMOVE'),
                      onPressed: () => cardCubit.removeCard(index),
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
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: TextButton(
          child: const Text("ADD CARD"),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: cardCubit,
                child: AddCardScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



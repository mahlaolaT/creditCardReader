import 'package:card_reader/cards.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());

  void validateCard(String cardNumber) {
    emit(CardLoading());
    // Simple validation logic for demonstration
    if (cardNumber.length == 16) {
      emit(CardValid(cardNumber));
    } else {
      emit(CardInvalid("Card number must be 16 digits long"));
    }
  }

  saveCard(
    String cardNumber,
    String countryIssued,
    String cardType,
    String expiryDate,
  ) async {
    Box<Cards> box = await Hive.openBox('cards');
    box.put(
      cardNumber,
      Cards(
        cardNumber: int.parse(cardNumber),
        countryIssued: countryIssued,
        cardType: cardType,
        expiryDate: expiryDate,
      ),
    );
  }

  savedCards() async {
    Box<Cards> box = await Hive.openBox('cards');
    List<Cards> cards = box.values.toList();
    emit(cards.isNotEmpty ? CardSaved(cards) : CardInitial());
  }

  removeCard(int index) async {
    Box<Cards> box = await Hive.openBox('cards');
    List<Cards> cards = box.values.toList();
    cards.removeAt(index);
    await box.deleteAt(index);
    emit(cards.isNotEmpty ? CardSaved(cards) : CardInitial());
  }
}

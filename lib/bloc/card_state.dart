import 'package:card_reader/cards.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardValid extends CardState {
  final String cardNumber;

  CardValid(this.cardNumber);
}

class CardInvalid extends CardState {
  final String errorMessage;

  CardInvalid(this.errorMessage);
}

class CardSaved extends CardState {
  final List<Cards> cards;

  CardSaved(this.cards);
}

import 'package:flutter/material.dart';

enum CardType {
  mastercard("mastercard"),
  visa("visa"),
  unknown("unknown");

  final String displayName;

  const CardType(this.displayName);

  static CardType fromDisplayName(String displayName) {
    switch (displayName.toLowerCase()) {
      case "mastercard":
        return CardType.mastercard;
      case "visa":
        return CardType.visa;
      default:
        return CardType.unknown;
    }
  }

  static Image getCardTypeIcon(CardType cardType) {
    switch (cardType.displayName) {
      case "mastercard":
        return Image.asset(
          "assets/images/mastercard.png",
          width: 42,
          height: 42,
        );

      case "visa":
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
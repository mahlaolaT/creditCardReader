import 'package:hive/hive.dart';
part 'cards.g.dart';
@HiveType(typeId: 1)
class Cards {

  Cards({this.cardNumber, this.countryIssued, this.cardType, this.expiryDate});

  @HiveField(0)
  int? cardNumber;

  @HiveField(1)
  String? countryIssued;

  @HiveField(2)
  String? cardType;

  @HiveField(3)
  String? expiryDate;
}

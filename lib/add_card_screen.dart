import 'package:card_reader/cards.dart';
import 'package:card_reader/cards_screen.dart';
import 'package:card_reader/main.dart';
import 'package:card_reader/scanner_screen.dart';
import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_config.dart';
import 'input_formatter.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  List<Country> allCountries = [];
  final _cardInfoKey = GlobalKey<FormState>();

  final TextEditingController _cardNoController = TextEditingController();
  final TextEditingController _countryOfIssueController = TextEditingController();
  final TextEditingController _cardTypeController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void initState() {
    for (var country in countries) {
      if (!AppConfig.bannedCountries.contains(country.name)) {
        allCountries.add(country);
      }
    }
    allCountries.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _cardInfoKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 15.0,
                                ),
                                child: const Icon(Icons.credit_card),
                              ),
                              const Text(
                                'Credit Card Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 10.0,
                          ),
                          child: TextFormField(
                            controller: _cardNoController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              InputFormatter(
                                  mask: 'xxxx xxxx xxxx xxxx', separator: ' '),
                            ],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.camera_alt_outlined),
                                onPressed: () => _scanCard(),
                              ),
                              labelText: 'Card Number',
                              hintText: 'Card Number',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid card number';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: true,
                            focusNode: FocusNode(canRequestFocus: false),
                            onTap: () {
                              showModalBottomSheet(
                                isDismissible: true,
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) => Expanded(
                                  child: ListView.builder(
                                    itemCount: allCountries.length,
                                    itemBuilder: (context, i) {
                                      final country = allCountries[i];
                                      return ListTile(
                                        title: Text(country.name),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _countryOfIssueController.text =
                                              country.name;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            controller: _countryOfIssueController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              labelText: 'Country Of Issue',
                              hintText: 'Country Of Issue',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select country ';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 10.0,
                          ),
                          child: TextFormField(
                            controller: _cardTypeController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Card Type',
                              hintText: 'Card Type',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter card type';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: TextFormField(
                                    controller: _expDateController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      InputFormatter(
                                          mask: 'MM/YY', separator: '/'),
                                    ],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: 'Exp. Date',
                                      hintText: 'MM/YY',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 15.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter expiry date';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: TextFormField(
                                    controller: _cvvController,
                                    maxLength: 3,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: 'CVV',
                                      hintText: 'CVV',
                                      counterText: '',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 15.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter valid CVV';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: ElevatedButton.icon(
                  //color: Colors.black,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add Card',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_cardInfoKey.currentState!.validate()) {
                      _saveCard().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CardsScreen(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scanCard() async {
    _cardInfoKey.currentState!.reset();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scanner(
          onScanCard: (cardInfo) {
            setState(() {
              _cardNoController.text = cardInfo.number;
              _cardTypeController.text = cardInfo.type;
              _expDateController.text = cardInfo.expiry;
            });
          },
        ),
      ),
    );
  }

  Future<void> _saveCard() async {
    int cardNumber = int.parse(_cardNoController.text);
    await box!.put(
      _cardNoController.text,
      Cards(
        cardNumber: cardNumber,
        countryIssued: _countryOfIssueController.text,
        cardType: _cardTypeController.text,
        expiryDate: _expDateController.text,
      ),
    );
  }
}

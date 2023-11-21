import 'package:card_reader/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_formatter.dart';

class CardInfoForm extends StatefulWidget {
  const CardInfoForm({Key? key}) : super(key: key);

  @override
  State<CardInfoForm> createState() => _CardInfoFormState();
}

class _CardInfoFormState extends State<CardInfoForm> {
  final _cardInfoKey = GlobalKey<FormState>();

  final TextEditingController _cardNoController = TextEditingController();
  final TextEditingController _countryOfIssueController = TextEditingController();
  final TextEditingController _cardTypeController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _cardInfoKey,
          child: Container(
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
                            onPressed: () {
                              _scanCard();
                            },
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: TextFormField(
                        controller: _countryOfIssueController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
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
                    Row(
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
                                InputFormatter(mask: 'MM/YY', separator: '/'),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _scanCard() async => Navigator.of(context).push(
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
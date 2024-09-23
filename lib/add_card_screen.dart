import 'package:card_reader/cards_screen.dart';
import 'package:card_reader/scanner_screen.dart';
import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_config.dart';
import 'bloc/card_cubit.dart';
import 'input_formatter.dart';

class AddCardScreen extends StatelessWidget {
  final GlobalKey<FormState> _cardInfoKey = GlobalKey<FormState>();
  final TextEditingController _cardNoController = TextEditingController();
  final TextEditingController _countryOfIssueController =
      TextEditingController();
  final TextEditingController _cardTypeController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CardCubit cardCubit = context.read<CardCubit>();
    final List<Country> allCountries = _getFilteredCountries();

    return Scaffold(
      body: Card(
        margin: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _cardInfoKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCardDetailsForm(context, allCountries, cardCubit),
                _buildAddCardButton(context, cardCubit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Country> _getFilteredCountries() {
    List<Country> countriesList = [];
    for (var country in countries) {
      if (!AppConfig.bannedCountries.contains(country.name)) {
        countriesList.add(country);
      }
    }
    countriesList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return countriesList;
  }

  Widget _buildCardDetailsForm(
      BuildContext context, List<Country> allCountries, CardCubit cardCubit) {
    return Column(
      children: [
        _buildCardNumberField(context),
        _buildCountryOfIssueField(context, allCountries),
        _buildCardTypeField(),
        _buildExpiryAndCVVFields(),
      ],
    );
  }

  Widget _buildCardNumberField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _cardNoController,
        inputFormatters: [
          InputFormatter(mask: 'xxxx xxxx xxxx xxxx', separator: ' ')
        ],
        decoration: InputDecoration(
          labelText: 'Card Number',
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 15.0,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          suffixIcon: IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () => _scanCard(context)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter valid card number' : null,
      ),
    );
  }

  Widget _buildCountryOfIssueField(
      BuildContext context, List<Country> allCountries) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _countryOfIssueController,
        readOnly: true,
        onTap: () => _showCountrySelection(context, allCountries),
        decoration: const InputDecoration(
          labelText: 'Country of Issue',
          suffixIcon: Icon(Icons.arrow_drop_down),
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
        validator: (value) =>
            value == null || value.isEmpty ? 'Please select country' : null,
      ),
    );
  }

  Widget _buildCardTypeField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _cardTypeController,
        decoration: const InputDecoration(
          labelText: 'Card Type',
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
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter card type' : null,
      ),
    );
  }

  Widget _buildExpiryAndCVVFields() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _expDateController,
              inputFormatters: [InputFormatter(mask: 'MM/YY', separator: '/')],
              decoration: const InputDecoration(
                labelText: 'Exp. Date',
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
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter expiry date' : null,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _cvvController,
              maxLength: 3,
              decoration: const InputDecoration(
                labelText: 'CVV',
                counterText: '',
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
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter valid CVV' : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton(BuildContext context, CardCubit cardCubit) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: const Text('Add Card'),
      onPressed: () {
        // if (_cardInfoKey.currentState!.validate()) {
        cardCubit
            .saveCard(
              _cardNoController.text,
              _countryOfIssueController.text,
              _cardTypeController.text,
              _expDateController.text,
            )
            .then((_) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: cardCubit..savedCards(),
                      child: const CardsScreen(),
                    ),
                  ),
                ));
        // }
      },
    );
  }

  void _showCountrySelection(BuildContext context, List<Country> allCountries) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView.builder(
        itemCount: allCountries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allCountries[index].name),
            onTap: () {
              Navigator.pop(context);
              _countryOfIssueController.text = allCountries[index].name;
            },
          );
        },
      ),
    );
  }

  Future<void> _scanCard(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scanner(
          onScanCard: (cardInfo) {
            _cardNoController.text = cardInfo.number;
            _cardTypeController.text = cardInfo.type;
            _expDateController.text = cardInfo.expiry;
          },
        ),
      ),
    );
  }
}

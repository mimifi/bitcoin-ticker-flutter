import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String cryptoCurrency;
  final double price;
  final String currencyValue;

  ReusableCard(
      {@required this.cryptoCurrency,
      @required this.price,
      @required this.currencyValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '$cryptoCurrency = $price $currencyValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

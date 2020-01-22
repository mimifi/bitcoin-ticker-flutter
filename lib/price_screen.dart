import 'package:bitcoin_ticker/Service/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropDownValue;
  dynamic lastPrice;
  NetworkHelper networkHelper = NetworkHelper();

  DropdownButton<String> getDropdownMenuItems() {
    List<DropdownMenuItem<String>> listOfItems = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      listOfItems.add(newItem);
    }

    return DropdownButton<String>(
      value: dropDownValue,
      items: listOfItems,
      onChanged: (String newValue) {
        setState(() {
          dropDownValue = newValue;
        });
      },
    );
  }

  CupertinoPicker getPickerItems() {
    List<Text> currencyWidgets = [];
    for (String currency in currenciesList) {
      currencyWidgets.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 30.0,
      children: currencyWidgets,
      onSelectedItemChanged: (itemPickerIndex) {
        setState(() {
          dropDownValue = currenciesList[itemPickerIndex];
        });
      },
    );
  }

  void updatePrice() async {
    lastPrice = await networkHelper.getResponse();
  }

  @override
  Widget build(BuildContext context) {
    updatePrice();

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = $lastPrice $dropDownValue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid
                  ? getDropdownMenuItems()
                  : getPickerItems()),
        ],
      ),
    );
  }
}

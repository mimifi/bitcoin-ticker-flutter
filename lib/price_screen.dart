import 'dart:io' show Platform;
import 'package:bitcoin_ticker/widgets/reusable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropDownValue;
  String crypto;
  List<double> targetPrices = [];

  CoinData coinData = CoinData();
  List<ReusableCard> reusableCards = [];

  Future<void> updatePrice() async {
    List<double> listOfTargetPrice =
        await coinData.updateTargetPrice(dropDownValue);
    setState(() {
      targetPrices = listOfTargetPrice;
    });
  }

  List<ReusableCard> createReusableCards() {
    reusableCards = [];
    for (var i = 0; i < cryptoList.length; i++) {
      ReusableCard card = ReusableCard(
        cryptoCurrency: cryptoList[i],
        price: targetPrices[i],
        currencyValue: dropDownValue,
      );
      reusableCards.add(card);
    }
    return reusableCards;
  }

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
      onChanged: (String newValue) async {
        await updatePrice();
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
      onSelectedItemChanged: (itemPickerIndex) async {
        dropDownValue = currenciesList[itemPickerIndex];
        await updatePrice();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dropDownValue = currenciesList.first;
    updatePrice();
    for (int index = 0; index < cryptoList.length; index++) {
      targetPrices.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createReusableCards(),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child:
                  Platform.isIOS ? getPickerItems() : getDropdownMenuItems()),
        ],
      ),
    );
  }
}

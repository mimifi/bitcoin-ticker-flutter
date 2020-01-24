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

  CoinData coinData = CoinData();
  List<ReusableCard> reusableCards = [];

  List<ReusableCard> createReusableCards() {
    reusableCards = [];
    for (String crypto in cryptoList) {
      ReusableCard card = ReusableCard(
        cryptoCurrency: crypto,
        price: lastBtcPrice,
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
        await coinData.updateBtcPrice(newValue);
        await coinData.updateEthPrice(dropDownValue);
        await coinData.updateLtcPrice(dropDownValue);
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
        await coinData.updateBtcPrice(dropDownValue);
        await coinData.updateEthPrice(dropDownValue);
        await coinData.updateLtcPrice(dropDownValue);
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dropDownValue = currenciesList.first;
    coinData.updateBtcPrice(dropDownValue).then((result) {
      setState(() {});
    });
    coinData.updateEthPrice(dropDownValue).then((result) {
      setState(() {});
    });
    coinData.updateLtcPrice(dropDownValue).then((result) {
      setState(() {});
    });
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

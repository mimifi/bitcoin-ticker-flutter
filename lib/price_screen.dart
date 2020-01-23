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
  double lastBtcPrice;
  double lastEthPrice;
  double lastLtcPrice;

  CoinData coinData = CoinData();

  Future<double> updateBtcPrice(currency) async {
    lastBtcPrice = await coinData.getResponse(
        sourceCurrency: cryptoList[0], targetCurrency: currency);
    return lastBtcPrice;
  }

  Future<double> updateEthPrice(currency) async {
    lastEthPrice = await coinData.getResponse(
        sourceCurrency: cryptoList[1], targetCurrency: currency);
    return lastBtcPrice;
  }

  Future<double> updateLtcPrice(currency) async {
    lastLtcPrice = await coinData.getResponse(
        sourceCurrency: cryptoList[2], targetCurrency: currency);
    return lastBtcPrice;
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
        await updateBtcPrice(newValue);
        await updateEthPrice(dropDownValue);
        await updateLtcPrice(dropDownValue);
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
        await updateBtcPrice(dropDownValue);
        await updateEthPrice(dropDownValue);
        await updateLtcPrice(dropDownValue);
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dropDownValue = currenciesList.first;
    updateBtcPrice(dropDownValue).then((result) {
      setState(() {});
    });
    updateEthPrice(dropDownValue).then((result) {
      setState(() {});
    });
    updateLtcPrice(dropDownValue).then((result) {
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
            children: <Widget>[
              ReusableCard(
                cryptoCurrency: cryptoList[0],
                price: lastBtcPrice,
                currencyValue: dropDownValue,
              ),
              ReusableCard(
                cryptoCurrency: cryptoList[1],
                price: lastEthPrice,
                currencyValue: dropDownValue,
              ),
              ReusableCard(
                cryptoCurrency: cryptoList[2],
                price: lastLtcPrice,
                currencyValue: dropDownValue,
              ),
            ],
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

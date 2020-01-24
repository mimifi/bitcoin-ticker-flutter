import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String defaultUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';
List<double> targetPrice = [];

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getResponse({sourceCurrency, targetCurrency}) async {
    String url = '$defaultUrl/$sourceCurrency$targetCurrency';

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      dynamic jsonData = convert.jsonDecode(data);
      double lastPrice = jsonData['last'];
      return lastPrice;
    } else {
      print('Request failed with status ${response.statusCode}.');
      return 0;
    }
  }

  Future<List<double>> updateTargetPrice(targetCurrency) async {
    List<double> targetPrices = [];
    for (var i = 0; i < cryptoList.length; i++) {
      targetPrices.add(
        await getResponse(
          sourceCurrency: cryptoList[i],
          targetCurrency: targetCurrency,
        ),
      );
    }
    return targetPrices;
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

double lastBtcPrice;
double lastEthPrice;
double lastLtcPrice;

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
  Future getResponse({sourceCurrency, targetCurrency}) async {
    String url =
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/$sourceCurrency$targetCurrency';

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      dynamic jsonData = convert.jsonDecode(data);
      double lastPrice = jsonData['last'];
      return lastPrice;
    } else {
      print('Request failed with status ${response.statusCode}.');
    }
  }

  Future<double> updateBtcPrice(targetCurrency) async {
    lastBtcPrice = await getResponse(
        sourceCurrency: cryptoList[0], targetCurrency: targetCurrency);
    return lastBtcPrice;
  }

  Future<double> updateEthPrice(targetCurrency) async {
    lastEthPrice = await getResponse(
        sourceCurrency: cryptoList[1], targetCurrency: targetCurrency);
    return lastEthPrice;
  }

  Future<double> updateLtcPrice(targetCurrency) async {
    lastLtcPrice = await getResponse(
        sourceCurrency: cryptoList[2], targetCurrency: targetCurrency);
    return lastLtcPrice;
  }
}

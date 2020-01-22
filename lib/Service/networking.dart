import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  Future getResponse(currency) async {
    String url =
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC$currency';

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
}

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  Future<dynamic> getResponse() async {
    String url =
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      double lastPrice = jsonResponse['last'];
      return lastPrice;
    } else {
      print('Request failed with status ${response.statusCode}.');
    }
  }
}

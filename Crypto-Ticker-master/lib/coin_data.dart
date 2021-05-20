import 'package:http/http.dart' as http;
import 'dart:convert';

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

const coinAPIURl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'A0910D93-8454-49C2-997B-15D0ECF400B5';

class CoinData {

  Future getCoinData(String selectedCurrency) async {
    Map<String,String> cryptoPrices = {};
    for(String crypto in cryptoList){
      String requestURL = '$coinAPIURl/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if(response.statusCode == 200){
          var decodedData = jsonDecode(response.body);
          double lastPrice = decodedData['rate'];
          cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      }else{
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}

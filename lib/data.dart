import 'networking.dart';

class Data {
  Future<dynamic> getData(String currency1, String currency2) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://free.currconv.com/api/v7/convert?q=${currency1}_$currency1&compact=ultra&apiKey=9eef8a74ce38e0e80496');
    var data = await networkHelper.getData();
    return data;
  }
}

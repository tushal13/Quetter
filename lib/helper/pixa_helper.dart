import 'dart:convert';

import 'package:http/http.dart' as http;

class PixaHelper {
  PixaHelper._();

  static final PixaHelper pixaHelper = PixaHelper._();

  Future<List?> getBackground({String query = ''}) async {
    String BgApi =
        'https://pixabay.com/api/?key=38359285-b3dce53fdcc47898d599b68df&q=$query&orientation=vertical&image_type=photo&safesearch=true&category=backgrounds';
    http.Response respons = await http.get(
      Uri.parse(
        BgApi,
      ),
    );
    if (respons.statusCode == 200) {
      var data = jsonDecode(respons.body);
      print("data:${data['hits']}");
      List allData = data['hits'];
      return allData;
    }
  }
}

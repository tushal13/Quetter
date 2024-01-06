import 'dart:convert';

import 'package:http/http.dart' as http;

class QuoteHelper {
  QuoteHelper._();

  static final QuoteHelper quoteHelper = QuoteHelper._();

  Future<List?> getQuotes({String query = ''}) async {
    String api =
        'https://api.quotable.io/quotes/random?tags=$query&minLength=10&limit=100&maxLength=100';
    http.Response response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List quotes = data;
      return quotes;
    }
  }
}

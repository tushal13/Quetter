import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class QuoteHelper {
  QuoteHelper._();

  static final QuoteHelper quoteHelper = QuoteHelper._();

  Future<List?> getQuotes({String query = ''}) async {
    String api = 'https://type.fit/api/quotes';
    http.Response response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List quotes = data;
      Logger().t(quotes);
      return quotes;
    }
  }
}

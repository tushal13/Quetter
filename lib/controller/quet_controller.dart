import 'package:flutter/cupertino.dart';

import '../helper/quet_helper.dart';

class QuoteCntroller extends ChangeNotifier {
  List quotes = [];
  List preferredQuotes = [];

  QuoteCntroller() {
    init();
  }

  init() async {
    quotes = await QuoteHelper.quoteHelper.getQuotes() ?? [];
    notifyListeners();
  }

  Prefrace({required List tags}) async {
    for (String element in tags) {
      List q = await QuoteHelper.quoteHelper.getQuotes(query: element) ?? [];
      preferredQuotes.addAll(q);
      notifyListeners();
    }
  }

  selectedPrefFunc(List tags, String val) async {
    if (tags.contains(val)) {
      tags.remove(val);
    } else {
      tags.add(val);
    }
    notifyListeners();
  }
}

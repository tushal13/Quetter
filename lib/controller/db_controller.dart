import 'package:flutter/cupertino.dart';
import 'package:quetter/helper/db_helper.dart';

import '../views/modal/quate_modal.dart';

class DbController extends ChangeNotifier {
  List<QuoteModal> dwonlods = [];

  DbController() {
    init();
  }
  init() async {
    dwonlods = await DBHelper.dbHelper.getDwonload();

    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

class TableManager extends ChangeNotifier {
  TableManager._();

  static final TableManager instance = TableManager._();

  String? _tableNumber;

  String? get tableNumber => _tableNumber;

  bool get hasTable => _tableNumber != null;

  void setTable(String tableNumber) {
    _tableNumber = tableNumber;
    notifyListeners();
  }

  void clearTable() {
    _tableNumber = null;
    notifyListeners();
  }
}

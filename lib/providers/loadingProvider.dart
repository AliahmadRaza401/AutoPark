import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
   late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }
  bool loading = false;

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}

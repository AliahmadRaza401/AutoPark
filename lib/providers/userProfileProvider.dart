import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkingapp/models/profileModel.dart';

class UserProfileProvider with ChangeNotifier {
   late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }
  bool userProfileloading = false;

  setLoading(bool value) {
    userProfileloading = value;
    // notifyListeners();
  }

  ProfileModel? profileModelInstance;

  saveProfleValue(valueofUser) {
    profileModelInstance = valueofUser;
    log('Value Saved Success');
    notifyListeners();
  }
}

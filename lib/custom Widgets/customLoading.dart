import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/AppColor.dart';

Widget customLoadingWidget() {
  return const Center(
    child: SpinKitThreeBounce(
      color: AppColor.primaryColor,
      size: 30.0,
    ),
  );
}

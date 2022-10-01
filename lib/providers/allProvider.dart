import 'package:parkingapp/providers/authentication_Provider.dart';
import 'package:parkingapp/providers/paymentProvider.dart';
import 'package:parkingapp/providers/userProfileProvider.dart';
import 'package:provider/provider.dart';

import 'allPrkingProvide.dart';
import 'loadingProvider.dart';

var allProvider = [
  ChangeNotifierProvider<LoadingProvider>(
    create: (_) => LoadingProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<GetAllParkingProvider>(
    create: (_) => GetAllParkingProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<UserProfileProvider>(
    create: (_) => UserProfileProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<AuthenticationProvider>(
    create: (_) => AuthenticationProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<PaymentProvider>(
    create: (_) => PaymentProvider(),
    lazy: true,
  ),
];

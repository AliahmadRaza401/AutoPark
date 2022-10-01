import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:parkingapp/providers/allProvider.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:parkingapp/utils/constFile.dart';
import 'package:provider/provider.dart';
import 'All Screens/splashScreen/splashPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  Stripe.publishableKey = publishableKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, _) {
        return MultiProvider(
          providers: allProvider,
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ThemeData().colorScheme.copyWith(
                      secondary: AppColor.primaryColor,
                    ),
              ),
              home: const SplashScreen()),
        );
        // return MultiProvider(
        //   providers: allProvider,
        //   child: MaterialApp(
        //     debugShowCheckedModeBanner: false,
        //     title: '',
        //     theme:
        //         ThemeData(primarySwatch: Colors.blue, fontFamily: "Urbanist"),
        //     builder: (context, widget) {
        //       return MediaQuery(
        //         data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        //         child: widget!,
        //       );
        //     },
        //     home: const SplashScreen(),
        //     // home: PaymentScreenNew(),
        //   ),
        // );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, _) {
        return MultiProvider(
          providers: allProvider,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '',
            theme:
                ThemeData(primarySwatch: Colors.blue, fontFamily: "Urbanist"),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            home: const SplashScreen(),
            // home: PaymentScreenNew(),
          ),
        );
      },
    );
  }
}

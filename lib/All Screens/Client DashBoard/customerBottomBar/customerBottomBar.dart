import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/clientProfile%20Screen/clientProfileScreen.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/user%20booking.dart';
import 'package:parkingapp/All%20Screens/Client%20DashBoard/user%20favourite.dart';
import 'package:parkingapp/utils/appColor.dart';
import 'package:provider/provider.dart';

import '../home Screen/homeScreen.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    UserBookings(),
    UserFavourite(),
    ClientProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: Center(
          child: widgetOptions[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        selectedItemColor: AppColor.primaryColor,
        selectedLabelStyle: TextStyle(fontFamily: "Poppins", fontSize: 12.sp),
        unselectedLabelStyle: TextStyle(fontFamily: "Poppins", fontSize: 12.sp),
        unselectedItemColor: const Color(0xff2A2E32),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

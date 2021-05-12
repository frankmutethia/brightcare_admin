import 'package:brightcare_admin/add.dart';
import 'package:brightcare_admin/admin_home.dart';
import 'package:brightcare_admin/appointments.dart';
import 'package:brightcare_admin/appointments_screen.dart';
// import 'package:brightcare_admin/appointments.dart';
import 'package:brightcare_admin/chart_homepage.dart';
import 'package:brightcare_admin/display.dart';
import 'package:brightcare_admin/getting_started_screen.dart';
import 'package:brightcare_admin/login_screen.dart';
import 'package:brightcare_admin/register_screen.dart';
import 'package:brightcare_admin/splash_screen.dart';
import 'package:brightcare_admin/view_bookings.dart';
import 'package:flutter/material.dart';
// import 'package:msafiri_admin/add.dart';
// import 'package:msafiri_admin/admin_home.dart';
// import 'package:msafiri_admin/chart_homepage.dart';
// import 'package:msafiri_admin/display.dart';
// import 'package:msafiri_admin/login_screen.dart';
// import 'package:msafiri_admin/splash_screen.dart';
// import 'package:msafiri_admin/view_bookings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bright Care Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        Login.id: (context) => Login(),
        RegisterScreen.id: (context) => RegisterScreen(),
        AdminHome.id: (context) => AdminHome(),
        AddPackage.id: (context) => AddPackage(),
        ViewData.id: (context) => ViewData(),
        ChartHome.id: (context) => ChartHome(),
        Bookings.id: (context) => Bookings(),
        AppointmentsScreen.id: (context) => AppointmentsScreen(),
        GettingStartedScreen.id: (context) => GettingStartedScreen(),
      },
    );
  }
}

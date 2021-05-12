import 'dart:async';
// import 'package:msafiri_admin/login_screen.dart';
import 'package:brightcare_admin/getting_started_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushNamed(context, GettingStartedScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 180.0),
                        child: Center(
                          child: Text(
                            'Bright Care Admin',
                            style: TextStyle(
                              fontSize: 35.0,
                              color: Colors.white,
                              fontFamily: 'PatrickHand',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}


// https://assets6.lottiefiles.com/private_files/lf30_mec2ti4p.json  video conferencing
// https://assets6.lottiefiles.com/private_files/lf30_mec2ti4p.json admin sitted
// https://lottiefiles.com/34705-lock-cpu-cyber-security under lock
// https://lottiefiles.com/41632-reloading users
// import 'package:msafiri_admin/add.dart';
// import 'package:msafiri_admin/chart_homepage.dart';
// import 'package:msafiri_admin/display.dart';
import 'package:brightcare_admin/add.dart';
import 'package:brightcare_admin/appointments_screen.dart';
import 'package:brightcare_admin/display.dart';
import 'package:brightcare_admin/login_screen.dart';
import 'package:brightcare_admin/view_bookings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:msafiri_admin/view_bookings.dart';

class AdminHome extends StatelessWidget {
  static final String id = "admin";

  Widget _buildSingleContainer(
      {IconData icon, String count, String name, BuildContext context}) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, ViewData.id);
        },
        child: StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              List<DocumentSnapshot> count = snapshot.data.documents;
              var countlength = count.length;
              print(countlength);
              return Card(
                color: Colors.blueAccent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              icon,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        '$countlength',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  Widget _buildCard2(
      {IconData icon, int count, String name, BuildContext context}) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, AddPackage.id);
        },
        child: StreamBuilder(
            stream: Firestore.instance.collection('packages').snapshots(),
            builder: (context, snapshot) {
              List<DocumentSnapshot> coun = snapshot.data.documents;
              var countleng = coun.length;
              print(countleng);
              return Card(
                color: Colors.orangeAccent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        '$countleng',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  Widget _buildCard3(
      {IconData icon, int co, String name, BuildContext context}) {
    return InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, Bookings.id);
        },
        child: StreamBuilder(
            stream: Firestore.instance.collection('bookingpackage').snapshots(),
            builder: (context, snapshot) {
              List<DocumentSnapshot> co = snapshot.data.documents;
              var cou = co.length;
              print(cou);
              return Card(
                color: Colors.orangeAccent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        '$cou',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  // Widget _buildCard4(
  //     {IconData icon, int count, String name, BuildContext context}) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.pushNamed(context, ChartHome.id);
  //     },
  //     child: Card(
  //       color: Color(0xFFA5A5A5),
  //       child: Container(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   icon,
  //                   size: 30.0,
  //                   color: Colors.white,
  //                 ),
  //                 SizedBox(
  //                   width: 10.0,
  //                 ),
  //               ],
  //             ),
  //             Text(
  //               name,
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 22.0,
  //               ),
  //             ),
  //             Text(
  //               count.toString(),
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 50.0,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //}

  Widget _buildCard4(
      {IconData icon, int count, String name, BuildContext context}) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppointmentsScreen.id);
      },
      child: Card(
        color: Colors.greenAccent,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: 3.0,
            //unselectedLabelColor: Colors.grey,
            tabs: [
              Text(
                'DashBoard',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Admin HQ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: TabBarView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 30.0,
                  ),
                  child: GridView.count(
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    crossAxisCount: 2,
                    children: [
                      _buildSingleContainer(
                        context: context,
                        count: "",
                        icon: Icons.person,
                        name: "Users",
                      ),
                      _buildCard2(
                        context: context,
                        count: 1,
                        icon: Icons.add_moderator,
                        name: "Add Rehab Center",
                      ),
                      _buildCard3(
                        context: context,
                        co: 1,
                        icon: Icons.book,
                        name: "View Bookings",
                      ),
                      _buildCard4(
                        context: context,
                        count: 1,
                        icon: Icons.report,
                        name: "Reports",
                      ),
                      // _buildCard4(
                      //   context: context,
                      //   count: 1,
                      //   icon: Icons.money,
                      //   name: "Reports",
                      // ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: FlatButton(
                        child: Text('Logout'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(Login.id);
                        },
                      ),
                      //   FlatButton(
                      //     child: Text(
                      //       'Logout',
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //     onPressed: () {
                      //       Navigator.of(context).pushNamed(Login.id);
                      //     },
                      //   ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

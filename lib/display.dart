import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewData extends StatelessWidget {
  static final String id = "data";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Users Data",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        leading: Icon(
          Icons.arrow_back,
          size: 26.0,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('There is no Users');
          return new ListView(children: getUsers(snapshot));
        },
      ),
    );
  }

  getUsers(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => ListTile(
              title: Text(
                doc["name"],
                style: TextStyle(fontSize: 17.0),
              ),
              subtitle: Text(
                doc["email"],
                style: TextStyle(fontSize: 17.0),
              ),
            ))
        .toList();
  }
}

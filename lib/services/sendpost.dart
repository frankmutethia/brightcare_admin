import 'dart:convert';
// import 'package:msafiri_admin/models/post.dart';
import 'package:brightcare_admin/models/post.dart';
import 'package:http/http.dart' as http;

// Fetching data from the ApI
Future<Post> sendPost(
    String site, String location, String price, String imageurl) async {
  const String apiUrl = "https://5f25be51c85de2001629338c.mockapi.io/posts";

  final response = await http.post(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'site': site,
      'location': location,
      'price': price,
      'imageurl': imageurl,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

import 'dart:convert';
// import 'package:msafiri_admin/models/post.dart';
import 'package:brightcare_admin/models/post.dart';
import 'package:http/http.dart' as http;

// Fetching data from the ApI
Future<List<Post>> fetchPost() async {
  const String apiUrl = "https://5f25be51c85de2001629338c.mockapi.io/posts";

  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    // check whether the server response is Ok then parse the JSON
    List<Post> posts = (json.decode(response.body) as List)
        .map((data) => Post.fromJson(data))
        .toList();
    print(posts);
    return posts;
  } else {
    // if server does not retutn a 200 ok repsonse throw an exception
    throw Exception('Failed to load');
  }
}

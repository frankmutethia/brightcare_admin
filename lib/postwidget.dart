import 'package:flutter/material.dart';

import 'models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Function press;

  const PostWidget({
    Key key,
    this.post,
    this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

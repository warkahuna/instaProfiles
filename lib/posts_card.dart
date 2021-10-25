import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final double width;
  final double height;
  final String postImage;
  final int postLikes;
  const PostCard({
    Key key,
    this.width,
    this.height,
    this.postImage,
    this.postLikes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      width: width,
      height: height,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(postImage),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.remove_red_eye_outlined,
            color: Colors.white,
          ),
          Text(
            NumberFormat.compactCurrency(
              decimalDigits: 2,
              symbol: '',
            ).format(postLikes).toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

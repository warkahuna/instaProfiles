import 'package:flutter/material.dart';

class PostImageDisplay extends StatefulWidget {
  PostImageDisplay({Key key, this.mediaUrl}) : super(key: key);
  final String mediaUrl;
  @override
  _PostImageDisplayState createState() => _PostImageDisplayState();
}

class _PostImageDisplayState extends State<PostImageDisplay> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          width: _width,
          height: _height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(widget.mediaUrl),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Icon(
                Icons.close_rounded,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }
}

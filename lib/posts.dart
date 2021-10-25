import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yamuntutest/postImageDisplay.dart';
import 'package:yamuntutest/postVideoPlayer.dart';

import 'package:yamuntutest/posts_card.dart';

class PostsList extends StatefulWidget {
  PostsList({Key key, this.posts}) : super(key: key);
  final List posts;
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    var columnCount = 3;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GridView.count(
          physics: ScrollPhysics(),
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(1.0),
          crossAxisCount: columnCount,
          children: List.generate(
            widget.posts.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                columnCount: columnCount,
                position: index,
                duration: Duration(milliseconds: 375),
                child: ScaleAnimation(
                  scale: 0.5,
                  child: GestureDetector(
                    child: FadeInAnimation(
                      child: PostCard(
                          width: 200,
                          height: 200,
                          postImage: widget.posts[index]["node"]["display_url"],
                          postLikes: widget.posts[index]["node"]
                              ["edge_liked_by"]["count"]),
                    ),
                    onTap: () {
                      widget.posts[index]["node"]["is_video"]
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  PostVideoplayer(
                                mediaUrl: widget.posts[index]["node"]
                                    ["video_url"],
                              ),
                            )
                          : showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  PostImageDisplay(
                                mediaUrl: widget.posts[index]["node"]
                                    ["display_url"],
                              ),
                            );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return new AlertDialog(
      backgroundColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Container(
          alignment: Alignment.center,
          height: _height * 0.9,
          width: _width,
          child: PostVideoplayer()),
      actions: <Widget>[
        Container(
          height: _height * 0.05,
          width: _width,
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey.shade300,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shadowColor: Colors.black,
              elevation: 5,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

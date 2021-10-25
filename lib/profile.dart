import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamuntutest/404.dart';
import 'package:yamuntutest/api.dart';
import 'package:yamuntutest/loader.dart';
import 'package:yamuntutest/posts.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, this.userName}) : super(key: key);
  final String userName;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<dynamic>> futureData;

  @override
  void initState() {
    super.initState();

    futureData = Api().fetchProfileData(widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: futureData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> data) {
          if (data.hasData) {
            if (data.data[0]['result'] != "notFound") {
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "Profile Data",
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  shape: ContinuousRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                ),
                body: ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      data.data[0]["profile_pic_url"]),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '@' + data.data[0]["username"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 60,
                          child: Column(
                            children: [
                              Text(
                                NumberFormat.compactCurrency(
                                  decimalDigits: 2,
                                  symbol: '',
                                )
                                    .format(data.data[0]["edge_followed_by"]
                                        ["count"])
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                'followers',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: Column(
                            children: [
                              Text(
                                NumberFormat.compactCurrency(
                                  decimalDigits: 2,
                                  symbol: '',
                                )
                                    .format(
                                        data.data[0]["edge_follow"]["count"])
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                'follower',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 275,
                      child: Text(
                        data.data[0]["biography"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              )),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                              ),
                              height: 20,
                              child: Text(
                                'Recent 12 posts',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )),
                    Column(children: [
                      Container(
                          height: height / 2.5,
                          width: width,
                          child: PostsList(
                              posts: data.data[0]
                                  ["edge_owner_to_timeline_media"]["edges"])),
                    ])
                  ],
                ),
              );
            } else {
              return NotFound();
            }
          } else if (data.hasError) {
            // If something went wrong
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Profile data",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
              ),
              body: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                  ),
                  Text(
                    'Something went wrong...',
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 70.0),
                    child: GestureDetector(
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            futureData =
                                Api().fetchProfileData(widget.userName);
                          });
                        }),
                  )
                ],
              ),
            );
          }
          return Loader();
        });
  }
}

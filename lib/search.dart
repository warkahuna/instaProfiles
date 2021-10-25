import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:yamuntutest/profile.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final userName = TextEditingController();

  String popUpText = "Please make sure to provide a valide userName";

  @override
  void initState() {
    super.initState();
    popUpText = "Please make sure to provide a valide userName";
  }

  @override
  void dispose() {
    userName.dispose();

    super.dispose();
  }

  Widget _buildPopupDialog(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return new AlertDialog(
      title: Text(
        userName.text.isNotEmpty ? "INFO" : 'ALERT',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              popUpText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _width * (userName.text.isEmpty ? 0.46 : 0.4),
              alignment: Alignment.bottomLeft,
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
            userName.text.isNotEmpty
                ? Container(
                    alignment: Alignment.bottomRight,
                    width: _width * 0.3,
                    margin: const EdgeInsets.only(left: 12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RewardsMakingPage(
                                      totalRewardPoints: 5,
                                    )));*/
                      },
                      child: Text(
                        'Search',
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
                    ))
                : Container(),
          ],
        )
      ],
    );
  }

  checkEmpty() {
    if (userName.text.isEmpty) {
      setState(() {
        popUpText = "username can't be empty";
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ProfilePage(
                    userName: userName.text,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: _width * 0.9,
                height: _height * 0.2,
                child: Card(
                  color: Colors.grey.shade300,
                  shadowColor: Colors.grey.shade600,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: _height / 30.0,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: _width * 0.8,
                          child: TextField(
                            controller: userName,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "user name",
                              filled: true,
                              fillColor: Colors.purple.withOpacity(.1),
                              contentPadding: EdgeInsets.zero,
                              errorStyle: TextStyle(
                                backgroundColor: Colors.grey.shade300,
                                color: Colors.black,
                              ),
                              labelStyle: TextStyle(fontSize: 12),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 4),
                                borderRadius: inputBorder,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 5),
                                borderRadius: inputBorder,
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 7),
                                borderRadius: inputBorder,
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 8),
                                borderRadius: inputBorder,
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 5),
                                borderRadius: inputBorder,
                              ),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.bottomRight,
                                width: _width * 0.7,
                                child: ElevatedButton(
                                  onPressed: () {
                                    checkEmpty();
                                  },
                                  child: Text(
                                    'Search',
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

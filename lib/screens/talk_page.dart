import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sample_flutter_app/models/message.dart';
import 'package:sample_flutter_app/models/talk_room.dart';

class TalkPage extends StatefulWidget {
  TalkPage({Key? key}) : super(key: key);

  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController _talkController = TextEditingController();

  late File _image;

  late TalkModel _talkRoomInfo;
  initState() {}

  @override
  Widget build(BuildContext context) {
    _talkRoomInfo = ModalRoute.of(context)!.settings.arguments as TalkModel;
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(_talkRoomInfo.talkTitle),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.search, size: 25),
              SizedBox(width: 10),
              Icon(CupertinoIcons.phone, size: 25),
              SizedBox(width: 10),
              Icon(CupertinoIcons.line_horizontal_3, size: 25),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Expanded(child: SingleChildScrollView(child: talkScreen())),
            Expanded(child: talkScreen()),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                    top: const BorderSide(
                  color: Colors.black,
                  width: 1,
                )),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 5),
                      Icon(CupertinoIcons.add, size: 25),
                      SizedBox(width: 5),
                      Icon(CupertinoIcons.photo_camera, size: 25),
                      SizedBox(width: 5),
                      CupertinoButton(
                        child: Icon(CupertinoIcons.doc_chart, size: 25),
                        onPressed: () {
                          _onPickImageSelected();
                        },
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  Expanded(
                    child: CupertinoTextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLength: null,
                      maxLines: 5,
                      placeholder: "Input text",
                      controller: _talkController,
                      onSubmitted: _onTalkSubmitted,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 5),
                      // Icon(CupertinoIcons.airplane, size: 25),
                      CupertinoButton(
                        onPressed: () {
                          DocumentReference<Map<String, dynamic>> posts = FirebaseFirestore.instance.collection('messages').doc();
                          posts.set({
                            "content": _talkController.text,
                            "message_id": posts.id,
                            "post_user": userId,
                            "talk_id": _talkRoomInfo.talkId,
                            "create_time": DateTime.now(),
                            "update_time": DateTime.now(),
                            "is_image": false,
                            "image_path": "/url/base/path/storage",
                          });
                          _talkController.clear();
                        },
                        child: Icon(CupertinoIcons.airplane, size: 25),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget talkScreen() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("messages").where("talk_id", isEqualTo: _talkRoomInfo.talkId).orderBy("create_time").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final messages = MessagesModel().mapToMessage(snapshot.data);

            // return Center(child: Text("hogehoge"));
            return CustomScrollView(
              semanticChildCount: messages.length,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    // child: Center(child: Text(_talkRoomInfo.talkId)),
                  ),
                ),
                SliverSafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(top: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < messages.length) {
                          return Card(
                            margin:
                                messages[index].postUser == userId ? EdgeInsets.only(top: 5.0, left: 90.0, bottom: 5.0, right: 8.0) : EdgeInsets.only(top: 5.0, left: 8.0, bottom: 5.0, right: 90.0),
                            child: ListTile(
                              title: Text(messages[index].content),
                              subtitle: Text(messages[index].createTime.toString()),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            // return Text('no data');
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('has err');
          } else {
            return Text('not specified');
          }
        });
  }

  _onTalkSubmitted(String content) {
    // CollectionReference posts = FirebaseFirestore.instance.collection('messages');
    // posts.add({"content": content});
    DocumentReference<Map<String, dynamic>> posts = FirebaseFirestore.instance.collection('messages').doc();
    posts.set({
      "content": content,
      "message_id": posts.id,
      "post_user": userId,
      "talk_id": _talkRoomInfo.talkId,
      "create_time": DateTime.now(),
      "update_time": DateTime.now(),
      "is_image": false,
      "image_path": "/url/base/path/storage",
    });

    /// 入力欄をクリアにする
    _talkController.clear();
  }

  void _onPickImageSelected() async {
    var imageSource = ImageSource.camera;

    try {
      final file = await ImagePicker().getImage(source: imageSource);
      setState(() {
        _image = File(file!.path);
      });
      if (file == null) {
        throw Exception('ファイルを取得できませんでした');
      }
    } catch (e) {}
  }

  // void _startVerification() async {
  //   final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
  //   final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
  //   final List<Face> faces = await faceDetector.processImage(visionImage);
  //   setState(() {
  //     _numOfFaces = faces.length != null ? faces.length : 0;
  //     _isFaceRecognition = faces.length > 0 ? true : false;
  //   });
  //   faceDetector.close();
  // }
}

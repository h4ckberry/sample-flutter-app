import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_flutter_app/models/talk_room.dart';

// チャット画面用Widget
class TalkPage extends StatelessWidget {
  // const TalkPage(this.talkRooms

  @override
  Widget build(BuildContext context) {
    final TalkModel talkRoomInfo = ModalRoute.of(context)!.settings.arguments as TalkModel;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(talkRoomInfo.talkTitle),
      ),
      child: Center(
        child: Text("Chat View"),
      ),
    );
  }
}

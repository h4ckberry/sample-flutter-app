// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TalkModel {
  const TalkModel({
    required this.talkId,
    required this.talkTitle,
    required this.talkIcon,
    required this.isGroup,
    required this.targetUsers,
    required this.messages,
  });

  final String talkId;
  final String talkTitle;
  final String talkIcon;
  final bool isGroup;
  final List<String> targetUsers;
  final Object messages;
}

class TalkProvider with ChangeNotifier {
  // late TalkModel _talkModels;
  List<TalkModel> _talkRooms = [];

  List<TalkModel> get books {
    return [..._talkRooms];
  }

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TalkModel>?> fetchTalkData() async {
    // final userId = _firebaseAuth.currentUser.uid;
    final userId = "AfYNVi2ciMDYDOP1JC3m";
    final querySnapshot = await _firestore.collection("talks").where("target_users", arrayContains: userId).get();

    final responseTalkRooms = querySnapshot.docs
        .map((doc) => TalkModel(
              talkId: doc['talk_id'],
              talkTitle: doc['talk_title'],
              talkIcon: doc['talk_icon'],
              isGroup: doc['is_group'],
              targetUsers: doc['target_users'],
              messages: doc['messages'],
            ))
        .toList();

    this._talkRooms = responseTalkRooms;
    notifyListeners();
  }
}

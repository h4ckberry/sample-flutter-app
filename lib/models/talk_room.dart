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

class TalksModel {
  List<TalkModel> _talkRooms = [];
  List<TalkModel> get talks {
    return [..._talkRooms];
  }

  List<TalkModel> mapToTalk(snapshotData) {
    List<TalkModel> responseTalkRooms = [];
    responseTalkRooms = snapshotData.docs
        .map((doc) => TalkModel(
              talkId: doc['talk_id'],
              talkTitle: doc['talk_title'],
              talkIcon: doc['talk_icon'],
              isGroup: doc['is_group'],
              targetUsers: doc['target_users'].cast<String>() as List<String>,
              messages: doc['messages'],
            ))
        .toList()
        .cast<TalkModel>();

    return responseTalkRooms;
  }
}

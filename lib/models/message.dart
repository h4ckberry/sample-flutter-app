import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  const MessageModel({
    required this.messageId,
    required this.content,
    required this.postUser,
    required this.talkId,
    required this.createTime,
    required this.updateTime,
    required this.isImage,
  });

  final String messageId;
  final String content;
  final String postUser;
  final String talkId;
  final Timestamp createTime;
  final Timestamp updateTime;
  final bool isImage;
}

class MessagesModel {
  List<MessageModel> _messages = [];
  List<MessageModel> get messages {
    return [..._messages];
  }

  List<MessageModel> mapToMessage(snapshotData) {
    List<MessageModel> responseMessages = [];
    responseMessages = snapshotData.docs
        .map((doc) => MessageModel(
            messageId: doc['message_id'],
            content: doc['content'],
            postUser: doc['post_user'],
            talkId: doc['talk_id'],
            createTime: doc['create_time'],
            updateTime: doc['update_time'],
            isImage: doc['is_image']))
        .toList()
        .cast<MessageModel>();

    return responseMessages;
  }
}

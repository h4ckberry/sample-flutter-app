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
    required this.imagePath,
  });

  final String messageId;
  final String content;
  final String postUser;
  final String talkId;
  final DateTime createTime;
  final DateTime updateTime;
  final bool isImage;
  final String imagePath;
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
            createTime: doc['create_time'].toDate(),
            updateTime: doc['update_time'].toDate(),
            isImage: doc['is_image'],
            imagePath: doc['image_path']))
        .toList()
        .cast<MessageModel>();

    return responseMessages;
  }
}

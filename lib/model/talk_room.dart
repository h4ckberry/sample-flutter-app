class TalkRoom {
  const TalkRoom({
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

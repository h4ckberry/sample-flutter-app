import 'package:flutter/cupertino.dart';

class TalkTab extends StatefulWidget {
  @override
  _TalkTabState createState() {
    return _TalkTabState();
  }
}

class _TalkTabState extends State<TalkTab> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('トーク画面'),
        ),
      ],
    );
  }
}

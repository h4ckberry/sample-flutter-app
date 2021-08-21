import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:sample_flutter_app/common/styles.dart';
import 'package:sample_flutter_app/models/talk_room.dart';

class TalkRowItem extends StatelessWidget {
  const TalkRowItem({
    required this.talkRoom,
    required this.lastItem,
  });

  final TalkModel talkRoom;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: CupertinoListTile(
        contentPadding: EdgeInsets.all(5),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            child: Image.asset(
              'assets/images/sample/sample1.png',
              fit: BoxFit.fitHeight,
              width: 76,
              height: 76,
            ),
          ),
        ),
        title: Text(talkRoom.talkTitle),
        trailing: Icon(CupertinoIcons.ellipsis),
        onTap: () {
          print("onTap called.");
          Navigator.pushNamed(context, "/talk", arguments: talkRoom);
        },
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.productRowDivider,
          ),
        ),
      ],
    );
  }
}

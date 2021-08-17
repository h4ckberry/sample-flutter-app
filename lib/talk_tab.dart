import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter_app/talk_row_item.dart';
import 'model/talk_room.dart';

class TalkTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TalkModel>?>(
      future: Provider.of<TalkProvider>(context, listen: false).fetchTalkData(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          // 非同期処理未完了 = 通信中
          return Center(child: CircularProgressIndicator());
        }
        if (dataSnapshot.error != null) {
          return Center(child: Text('エラーがおきました'));
        }

        return Consumer<TalkProvider>(
          builder: (context, model, child) {
            final talks = dataSnapshot.data!;
            return CustomScrollView(
              semanticChildCount: talks.length,
              slivers: <Widget>[
                const CupertinoSliverNavigationBar(
                  largeTitle: Text('トーク画面'),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: CupertinoSearchTextField(
                      onChanged: (String value) {
                        print('The text has changed to: $value');
                      },
                      onSubmitted: (String value) {
                        print('Submitted text: $value');
                      },
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverHeaderDelegate(80, 50),
                  floating: false,
                  pinned: true,
                ),
                SliverSafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(top: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // if (index < ) {
                        return TalkRowItem(
                          talkRoom: talks[index],
                          lastItem: index == talks.length - 1,
                        );
                        // }
                        // return null;
                      },
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  double _maxExtent, _minExtent;

  _SliverHeaderDelegate(this._maxExtent, this._minExtent);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Container(
        color: overlapsContent ? Colors.red : Colors.lightBlue,
        child: Center(child: Text("広告")),
        // child: Center(child: Text("$shrinkOffset")),
      ),
    );
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this || oldDelegate?.maxExtent != this.maxExtent || oldDelegate?.minExtent != this.minExtent;
  }
}

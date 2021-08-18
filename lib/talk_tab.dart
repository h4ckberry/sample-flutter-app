import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter_app/talk_row_item.dart';
import 'model/talk_room.dart';

class TalkTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TalkProvider>(context, listen: false).fetchTalkData(),
      builder: (context, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          // 非同期処理未完了 = 通信中
          return Center(child: CircularProgressIndicator());
        }
        if (dataSnapshot.hasData) {
          return Consumer<TalkProvider>(
            builder: (context, model, child) {
              final talks = model.getTalks();
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
                          if (index < talks.length) {
                            return TalkRowItem(
                              talkRoom: talks[index],
                              lastItem: index == talks.length - 1,
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          );
        } else if (!dataSnapshot.hasData) {
          return Center(child: Text('no data'));
        } else if (dataSnapshot.hasError) {
          return Center(child: Text('has err'));
        } else {
          return Center(child: Text('not specified'));
        }
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

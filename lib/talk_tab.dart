// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_flutter_app/talk_row_item.dart';

class TalkTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return CustomScrollView(
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
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      // return TalkRowItem(
                      //   talkRoom: snapshot.data!.docs[index],
                      //   itemIndex: index,
                      // );
                      return Container(
                        child: Text(snapshot.data!.docs[index].get('status_message')),
                      );
                    }, childCount: snapshot.data!.docs.length),
                  ),
                )
              ],
            );
          } else if (!snapshot.hasData) {
            return Text('no data');
          } else if (snapshot.hasError) {
            return Text('has err');
          } else {
            return Text('not specified');
          }
        });
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

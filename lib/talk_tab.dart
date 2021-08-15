import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'model/app_state_model.dart';
// import 'product_row_item.dart';

class TalkTab extends StatefulWidget {
  @override
  _TalkTabState createState() {
    return _TalkTabState();
  }
}

class _TalkTabState extends State<TalkTab> {
  @override
  Widget build(BuildContext context) {
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
              return Container(padding: EdgeInsets.all(20.0), child: Text('Row_$index'));
            }),
          ),
        )
      ],
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

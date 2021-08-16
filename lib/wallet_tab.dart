import 'package:flutter/cupertino.dart';

class WalletTab extends StatefulWidget {
  @override
  _WalletTabState createState() {
    return _WalletTabState();
  }
}

class _WalletTabState extends State<WalletTab> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('ウォレット画面'),
        ),
      ],
    );
  }
}

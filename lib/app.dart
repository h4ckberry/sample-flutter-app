import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_flutter_app/styles.dart';

import 'home_tab.dart';
import 'talk_tab.dart';
import 'news_tab.dart';
import 'wallet_tab.dart';
import 'time_line.dart';

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            title: Text("ホーム", style: googleFontRobot(9.0, FontWeight.w100, 1.0, [0,0,0])),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2_fill, size: 28),
            title: Text("トーク", style: googleFontRobot(9.0, FontWeight.w100, 1.0, [0,0,0])),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule, size: 26),
            title: Text("タイムライン", style: googleFontRobot(9.0, FontWeight.w100, 1.0, [0,0,0])),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article, size: 26),
            title: Text("ニュース", style: googleFontRobot(9.0, FontWeight.w100, 1.0, [0,0,0])),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment, size: 26),
            title: Text("ウォレット", style: googleFontRobot(9.0, FontWeight.w100, 1.0, [0,0,0])),
          ),
        ],
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        border: Border.all(color:Colors.white ,width: 0),
        activeColor: Colors.black,
        inactiveColor: Color.fromRGBO(0, 0, 0, 0.2),
      ),
      tabBuilder: (context, index) {
        late final CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomeTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TalkTab(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TimeLineTab(),
              );
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: NewsTab(),
              );
            });
            break;
          case 4:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: WalletTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter_app/models/app_state_model.dart';

class TimeLineTab extends StatefulWidget {
  @override
  _TimeLineTabState createState() {
    return _TimeLineTabState();
  }
}

class _TimeLineTabState extends State<TimeLineTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return const CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('タイムライン画面'),
            ),
          ],
        );
      },
    );
  }
}

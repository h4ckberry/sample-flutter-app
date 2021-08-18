import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample_flutter_app/model/talk_room.dart';

import 'app.dart';
import 'model/app_state_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateModel>(create: (_) => AppStateModel()..loadProducts()),
        ChangeNotifierProvider<TalkProvider>(create: (_) => TalkProvider()..fetchTalkData()),
      ],
      child: BaseApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/app.dart';
import 'models/app_state_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateModel>(create: (_) => AppStateModel()..loadProducts()),
      ],
      child: BaseApp(),
    ),
  );
}

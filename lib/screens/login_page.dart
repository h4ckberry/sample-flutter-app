import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String? emailValidator(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value != null && !regex.hasMatch(value)) {
      return '正しいEmailのフォーマットで入力してください';
    } else {
      return null;
    }
  }

  String? pwdValidator(String? value) {
    if (value != null && value.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Login App'),
        ),
        child: loginscreen());
  }

  Widget loginscreen() {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(children: <Widget>[
                CupertinoFormSection.insetGrouped(
                  header: const Text('SECTION 1'),
                  children: <Widget>[
                    CupertinoTextFormFieldRow(
                      prefix: const Text('Email: '),
                      placeholder: 'hogehoge.fugaguga@gmail.com',
                      controller: emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: const Text('Password: '),
                      placeholder: '********',
                      controller: pwdInputController,
                      obscureText: true,
                      validator: pwdValidator,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                CupertinoButton(
                  child: Text(
                    "ログイン",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: emailInputController.text,
                            password: pwdInputController.text,
                          )
                          .then((currentUser) => FirebaseFirestore.instance
                              .collection("users")
                              .doc(currentUser.user!.uid)
                              .get()
                              .then((DocumentSnapshot result) => {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()))})
                              .catchError((err) => print(err)))
                          .catchError((err) => print(err));
                    }
                  },
                ),
                CupertinoButton(
                  child: Text(
                    "アカウントを作成する",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                )
              ]),
            ),
          )),
    );
  }
}

import "package:flutter/material.dart";
import 'package:jobcan_automation/pages/home_pages.dart';

import '../utils/hexColor.dart';
import '../utils/shared_prefs.dart';

class UserEditPage extends StatefulWidget {
  const UserEditPage({Key? key}) : super(key: key);

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  static setValue(name, email, password) async {
    await SharedPrefs.setPrefsInstance();
    SharedPrefs.setProf(name, email, password);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: HexColor("#add8e6"),
          title: const Text("ログイン情報編集", style: TextStyle(color: Colors.black))),
      body: Center(
        child: SizedBox(
          width: size.width * 0.8,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text("ジョブカンログイン情報編集", style: TextStyle(fontSize: 25)),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: Text("お名前 ",
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.greenAccent,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("メールアドレス ",
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.greenAccent,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("パスワード ",
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.greenAccent,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.amber,
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    var name = _nameController.text;
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    if (email == "" || password == "") {
                      print("値が空だよ");
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      setValue(name, email, password);
                    }
                  },
                  child: const Text('保存'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

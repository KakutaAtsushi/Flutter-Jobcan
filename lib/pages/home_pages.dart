import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:jobcan_automation/pages/user_edit_pages.dart';

import '../utils/hexColor.dart';
import '../utils/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _time = '';

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), _onTimer);
    super.initState();
  }

  void showProgressDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        });
  }

  Future<dynamic> _request(method) async {
    Uri url = Uri.parse("https://jobcan-automation.herokuapp.com/jobcan_auto");
    await SharedPrefs.setPrefsInstance();
    Map<String, String> headers = {
      'content-type': 'application/x-www-form-urlencoded'
    };
    Map<String, String> body = {
      "method": "$method",
      'email': SharedPrefs.fetchEmail() ?? "",
      'password': SharedPrefs.fetchPassword() ?? ""
    };

    http.Response resp = await http.post(url, headers: headers, body: body);
    print(resp.body);
    return json.decode(resp.body);
  }

  void _onTimer(Timer timer) {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('HH:mm:ss');
    String dateStr = dateFormat.format(now);
    setState(() => {_time = dateStr});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.settings),
                tooltip: '設定',
                iconSize: 25,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserEditPage()),
                  );
                }),
          ],
          backgroundColor: HexColor("#add8e6"),
          title: const Text(
            "ホーム",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(SharedPrefs.fetchUsername() ?? "ようこそ、ななしさん",
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 15, color: Colors.grey)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                  child: Text(
                _time,
                style: const TextStyle(fontSize: 70),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.height * 0.2,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        showProgressDialog();
                        // ３秒後にダイアログを閉じる
                        dynamic resp = await _request(0);
                        await Future.delayed(const Duration(seconds: 30));
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 5),
                            content: Text(resp["message"])));
                      },
                      icon: const Icon(Icons.work),
                      label: const Text('出勤'),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.height * 0.2,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        showProgressDialog();
                        dynamic resp = await _request(1);
                        await Future.delayed(const Duration(seconds: 25));
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 5),
                            content: Text(resp["message"])));
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('退勤'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

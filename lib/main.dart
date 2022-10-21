import 'package:flutter/material.dart';
import 'package:jobcan_automation/pages/home_pages.dart';
import 'utils/hexColor.dart';
import "pages/init_register_pages.dart";
import 'utils/shared_prefs.dart';

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.setPrefsInstance();
  String? myEmail = SharedPrefs.fetchEmail();
  if (myEmail != null) {
    runApp(const MaterialApp(
      home: HomePage(),
    ));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobCan自動ログインくん',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'JobCan自動ログインくん',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor("#add8e6"),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 13.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.done_all,
                size: 300,
              ),
            ),
            const SizedBox(
              width: 230,
              height: 100,
              child: Text(
                'ジョブカンのログイン'
                'を半自動化しよう!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InitRegister()));
              },
              child: const Text("早速自動化する！！！！", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

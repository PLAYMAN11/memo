import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/config/config.dart';
import 'dart:io';

import '../config/session.dart';
import '../widgets/botonera.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          TextSpan(text: "Memo \n"),
          TextSpan(text: "Victorias: ${wins} "),
          TextSpan(text: "Derrotas: ${loses} ")
        ])),
        actions: <Widget>[
          IconButton(onPressed: () {
            if (Platform.isAndroid || Platform.isIOS){
             // Navigator.pop(context);
              //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              SystemNavigator.pop();

            }
            if (Platform.isLinux || Platform.isWindows){
              exit(0);
            }
          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: const Botonera(),

    );
  }
}

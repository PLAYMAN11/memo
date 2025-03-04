import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo/config/session.dart';
import 'package:memo/db/sqlite.dart';

import '../db/user.dart';

class consulta extends StatefulWidget {
  const consulta({super.key});

  @override
  State<consulta> createState() => _consultaState();
}

class _consultaState extends State<consulta> {
  List<User>? users;
  @override
  void initState() {
    super.initState();
    users = [];
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Consulta"),
        ),
        body: Builder(builder: (context) {
          consultar();
          if (users!.isEmpty) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: users!.length,
            itemBuilder: (context, index) {
              return Card(
                child: CupertinoListTile(
                  title: Text(users![index].difficulty!),
                  subtitle: Text(
                      "wins: ${users![index].wins!} losses: ${users![index].loses} Date: ${users![index].date}"),

                ),
              );
            },
          );
        }));
  }

  Future<void> consultar() async {
    users = await Sqlite.consulta().whenComplete(
      () {
        setState(() {});
      },
    );
  }
}

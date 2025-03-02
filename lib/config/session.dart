library session.globals;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/config/config.dart';
import 'package:memo/config/session.dart';

import '../db/sqlite.dart';
import '../db/user.dart';

double Gsize = 0;
final counter = Stopwatch();
int moves = 0;
int wins = 0;
int loses = 0;
User? user = null;
bool isfirst = true;
double pair = 0;
int? prevclicked;
bool? flag, habilitado;

AlertDialog Consultar(BuildContext context) {
  return AlertDialog(
      title: Text("Sesión Anterior"),
      content: FutureBuilder<User?>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (user == null) {
              return Text("Aun no hay datos");
            } else {
              return Text(
                  "Fecha: ${user?.date}\nWins: ${user?.wins}\nLosses: ${user?.loses}");
            }
          }
          ),
    actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
}, child: Text("Ok")),
    ],
  );
}

Future<User?> getUser() async {
  user = await Sqlite.consulta();
  return user;
}

AlertDialog Salir(BuildContext context) {
  return AlertDialog(
    title: Text("¿Está seguro que desea salir?"),
    content:
        Text("Sus victorias y derrotas de esta sesión se guardarán al salir."),
    actions: [
      TextButton(
        onPressed: () {
          DateTime now = DateTime.now();
          String formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
          Sqlite.add(User(wins, loses, formattedDate));
          if (Platform.isAndroid || Platform.isIOS) {
            SystemNavigator.pop();
          }
          if (Platform.isLinux || Platform.isWindows) {
            exit(0);
          }
        },
        child: Text("Sí"),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("No"),
      ),
    ],
  );
  
}


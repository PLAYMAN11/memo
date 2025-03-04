library session.globals;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/app/home.dart';
import 'package:memo/config/config.dart';
import 'package:memo/config/counter.dart';
import 'package:memo/config/session.dart';

import '../db/sqlite.dart';
import '../db/user.dart';

double Gsize = 0;
int moves = 0;
int wins = 0;
int loses = 0;
User? user = null;
bool isfirst = true;
double pair = 0;
int? prevclicked;
bool? flag, habilitado;
String? parrillaKey;

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
        }),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Ok")),
    ],
  );
}

Future<User?> getUser() async {
  user = await Sqlite.consulta();
  return user;
}

AlertDialog NewGame(BuildContext context) {
  return AlertDialog(
    title: Text("¿Empezar un nuevo juego?"),
    content: Text("Se tomará como una partida perdida"),
    actions: [
      TextButton(
          onPressed: () {
            parrillaKey = DateTime.now().millisecondsSinceEpoch.toString();
            Navigator.of(context).pop();
          },
          child: Text("Si")),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("No"))
    ],
  );
}

AlertDialog Restart(BuildContext context) {
  return AlertDialog(
    title: Text("¿Empezar un nuevo juego?"),
    content: Text("No se contará como partida perdida"),
    actions: [
      TextButton(
          onPressed: () {
            parrillaKey = DateTime.now().millisecondsSinceEpoch.toString();
            Navigator.of(context).pop();
          },
          child: Text("Si")),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("No"))
    ],
  );
}

AlertDialog SalirLvl(BuildContext context) {
  return AlertDialog(
    title: Text("¿Está seguro que desea salir?"),
    content:
        Text("Sus victorias y derrotas de esta sesión se guardarán al salir."),
    actions: [
      TextButton(
        onPressed: () {
          DateTime now = DateTime.now();
          String formattedDate =
              "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
          Sqlite.add(User(wins, loses, formattedDate));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
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

AlertDialog Lost(BuildContext context) {
  return AlertDialog(
    title: Text("Se ha acabado el tiempo"),
    content: Text("Git --gud"),
    actions: [
      TextButton(
          onPressed: () {
            parrillaKey = DateTime.now().millisecondsSinceEpoch.toString();
            Navigator.of(context).pop();
          },
          child: Text("Nueva Partida")),
      TextButton(
          onPressed: () {
            stopTimer();
            resetTimer();
            DateTime now = DateTime.now();
            resetGameState();
            
            String formattedDate =
                "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
            Sqlite.add(User(wins, loses, formattedDate));
            wins=0;
            loses=0;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false,
            );
          },
          child: Text("Salir"))
    ],
  );
}
void resetGameState() {
  moves = 0;
  pair = Gsize;
  prevclicked = -1;
  flag = false;
  habilitado = false;
  isfirst = true;
  wins=0;
  loses=0;
}

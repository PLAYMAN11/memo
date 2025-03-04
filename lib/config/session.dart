library session.globals;

import 'dart:core';
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
import '../widgets/consulta.dart';

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
    title: Text("¿Desea consultar sus datos?"),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => consulta()));
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
            loses--;
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

AlertDialog SalirLvl(BuildContext context, Nivel? nivel) {
  return AlertDialog(
    title: Text("¿Está seguro que desea salir?"),
    content:
        Text("Sus victorias y derrotas de esta sesión se guardarán al salir."),
    actions: [
      TextButton(
        onPressed: () {
          stopTimer();
          resetTimer();
          DateTime now = DateTime.now();
          resetGameState();

          String formattedDate =
              "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
          Sqlite.add(User(wins, loses, formattedDate, nivel?.name));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false,
          );
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

AlertDialog Lost(BuildContext context, Nivel? nivel) {
  return AlertDialog(
    title: Text("Se ha acabado el tiempo"),
    content: Text("git --gud"),
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
            Sqlite.add(User(wins, loses, formattedDate, nivel?.name));
            wins = 0;
            loses = 0;
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
  wins = 0;
  loses = 0;
}

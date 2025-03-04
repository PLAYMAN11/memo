import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/config/config.dart';
import 'package:memo/config/counter.dart';
import 'package:memo/db/sqlite.dart';
import 'package:memo/db/user.dart';
import 'package:memo/widgets/bottomAppBar.dart';
import 'package:memo/widgets/parrilla.dart';

import '../config/session.dart';

enum SampleItem { itemOne, itemTwo, itemThree, itemFour }

class Tablero extends StatefulWidget {
  final Nivel? nivel;

  const Tablero(this.nivel, {Key? key}) : super(key: key);

  @override
  _TableroState createState() => _TableroState();
}

class _TableroState extends State<Tablero> {
  late Timer timer;
  SampleItem? selectedItem;

  @override
  void initState() {
    super.initState();
    parrillaKey = DateTime.now().millisecondsSinceEpoch.toString();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: "Nivel: ${widget.nivel?.name}\n"),
              WidgetSpan(
                child: Icon(Icons.access_alarm),
              ),
              TextSpan(text: "${getTime()}"),
              WidgetSpan(
                  child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  )), 
              TextSpan(text:"Movimientos: ${moves}")
            ], style: TextStyle(fontSize: 17))),
          ],
        ),
        actions: [
          PopupMenuButton<SampleItem>(
            initialValue: selectedItem,
            onSelected: (SampleItem item) {
              setState(() {
                selectedItem = item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                  value: SampleItem.itemOne,
                  child: Text('Reiniciar'),
                  onTap: () => {
                        showDialog(
                            context: context,
                            builder: (context) => Restart(context)),
                      }),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: Text('Consultar'),
                onTap: () => {
                  Sqlite.consulta(),
                  showDialog(
                      context: context,
                      builder: (context) => Consultar(context))
                },
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemThree,
                child: Text('Salir'),
                onTap: () => {
                  showDialog(
                      context: context, builder: (context) => SalirLvl(context))
                },
              ),
              PopupMenuItem<SampleItem>(
                  value: SampleItem.itemFour,
                  child: Text('Nuevo Juego'),
                  onTap: () => {
                        showDialog(
                            context: context,
                            builder: (context) => NewGame(context)),
                      }),
            ],
          ),
        ],
      ),
      body: Parrilla(widget.nivel, key: ValueKey(parrillaKey)),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/config/config.dart';
import 'package:memo/db/sqlite.dart';
import 'package:memo/db/user.dart';
import 'package:memo/widgets/parrilla.dart';

import '../config/session.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

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
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: "Nivel: ${widget.nivel?.name}"),
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Icon(Icons.access_alarm),
              )),
              TextSpan(
                  text:
                      "${formatElapsedTime(counter.elapsed)}\nMovimientos: ${moves}"),
            ])),
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
                        for(int i=0; i<controles.length; i++){
                          if (!controles[i].state!.isFront) {
                            controles[i].toggleCard(),
                          },
                          estados[i] = true
                        },
                        setState(() {
                          prevclicked = -1;
                          pair = Gsize;
                          counter.reset();
                          moves = 0;
                          flag = false;
                          habilitado = true;
                        }),
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
                      context: context, builder: (context) => Salir(context))
                },
              ),
            ],
          ),
        ],
      ),
      body: Parrilla(widget.nivel),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/config/config.dart';
import 'package:memo/widgets/bottomAppBar.dart';
import 'dart:io';

import '../config/session.dart';
import '../db/sqlite.dart';
import '../widgets/botonera.dart';
import '../widgets/tablero.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Timer timer;

  SampleItem? selectedItem;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          TextSpan(text: "Memorama"),
        ])),
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
            ],
          ),
        ],
        automaticallyImplyLeading: false,

      ),
      body: const Botonera()

    );
  }
}

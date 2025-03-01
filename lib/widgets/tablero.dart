import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:memo/config/config.dart';
import 'package:memo/widgets/parrilla.dart';

class Tablero extends StatefulWidget {
  final Nivel? nivel;
  const Tablero(this.nivel, {Key? key}) : super(key: key);

  @override
  _TableroState createState() => _TableroState();
}

class _TableroState extends State<Tablero> {
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
        title: Row(
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: "Nivel: ${widget.nivel?.name}"),
              WidgetSpan(child: Padding(padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Icon(Icons.access_alarm),
              )),
              TextSpan(text: "${formatElapsedTime(counter.elapsed)}\nMovimientos: ${moves}")
            ])),],
          
        ),
        
      ),
      body: Parrilla(widget.nivel),
    );
  }
}
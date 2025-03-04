import 'package:flutter/material.dart';
import 'package:memo/config/config.dart';

import '../config/session.dart' as session;

class BottomMenu extends StatefulWidget {
  final Nivel? nivel;
  
  const BottomMenu(this.nivel, {super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => session.SalirLvl(context, widget.nivel));
              },
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
                size: 35,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => session.Restart(context));
              },
              icon: Icon(
                Icons.restart_alt,
                color: Colors.white,
                size: 35,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => session.NewGame(context));
              },
              icon: Icon(
                Icons.new_label,
                color: Colors.white,
                size: 35,
              ))
        ],
      ),
    );
  }
}

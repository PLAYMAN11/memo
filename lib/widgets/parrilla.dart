import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memo/config/counter.dart';
import '../app/home.dart';
import '../config/config.dart';
import 'package:flip_card/flip_card.dart';
import '../config/session.dart';
import '../db/sqlite.dart';
import '../db/user.dart';

class Parrilla extends StatefulWidget {
  final Nivel? nivel;

  const Parrilla(this.nivel, {Key? key}) : super(key: key);

  @override
  _ParrillaState createState() => _ParrillaState();
}

class _ParrillaState extends State<Parrilla> {

  bool mostrarCartas = true;
  int space =0;

  final TextStyle downtext = TextStyle(color: Colors.grey);

  @override
  void initState() {
    super.initState();
    controles = [];
    baraja = [];
    estados = [];
    barajar(widget.nivel!);
    prevclicked = -1;
    flag = false;
    habilitado = false;
    isfirst =true;
    pair = Gsize;
    loses++;
    moves = 0;
    space= (Platform.isLinux ? 10 :4);

    Future.delayed(Duration.zero, () {
      for (var controller in controles) {
        controller.toggleCard();
        resetTimer();
      }
    });

    Future.delayed(Duration(seconds: 3), () {
      for (var controller in controles) {
        controller.toggleCard();
      }
      setState(() {
        habilitado = true;
        mostrarCartas = false;
        isfirst = false;
        startTimer(context, widget.nivel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Parejas: ${Gsize.toInt()}", style: downtext),
              Text("Parejas Restantes: ${pair.toInt()}", style: downtext),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        Flexible(
          child: GridView.builder(
            itemCount: baraja.length,
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: space) ,
            itemBuilder: (context, index) {
              return FlipCard(
                onFlip: () {
                  if (isfirst!) {
                    return;
                  }
                  if (!flag!) {
                    prevclicked = index;
                    estados[index] = false;
                  } else {
                    setState(() {
                      habilitado = false;
                    });
                  }
                  flag = !flag!;
                  estados[index] = false;
                  if (prevclicked != index && !flag!) {
                    if (baraja.elementAt(index) ==
                        baraja.elementAt(prevclicked!)) {
                      debugPrint("clicked: Son iguales");
                      setState(() {
                        habilitado = true;
                        pair--;
                        moves++;
                        if (pair == 0) {
                          ++wins;
                          --loses;
                          stopTimer();
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              title: Text("Juego Terminado"),
                              content: Text("Tu Tiempo: ${getTime()}\n"
                                  "Movimientos: ${moves}", style: TextStyle(fontSize: 18),),
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

                                      String formattedDate =
                                          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
                                      Sqlite.add(User(wins, loses, formattedDate, widget.nivel?.name));
                                      resetGameState();
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
                            ),
                          );
                        }
                      });
                    } else {
                      Future.delayed(
                        Duration(seconds: 1),
                        () {
                          controles.elementAt(prevclicked!).toggleCard();
                          estados[prevclicked!] = true;
                          prevclicked = index;
                          controles.elementAt(index).toggleCard();
                          estados[index] = true;
                          setState(() {
                            habilitado = true;
                            moves++;
                          });
                        },
                      );
                    }
                  } else {
                    setState(() {
                      habilitado = true;
                    });
                  }
                },
                controller: controles[index],
                flipOnTouch: habilitado! ? estados.elementAt(index) : false,
                front: Image.asset("images/quest.png"),
                back: Image.asset(baraja[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

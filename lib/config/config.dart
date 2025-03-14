library config.globals;

import 'dart:io';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo/utilis/detalles.dart';

import '../db/sqlite.dart';
import '../db/user.dart';
import '../widgets/tablero.dart';
import 'session.dart';


enum Nivel {facil, medio, dificil,imposible}

List<String> cards() {
  return [
  "images/cloud.png",
  "images/cloud.png",
  "images/day.png",
  "images/day.png",
  "images/dino.png",
  "images/dino.png",
  "images/fish.png",
  "images/fish.png",
  "images/frog.png",
  "images/frog.png",
  "images/moon.png",
  "images/moon.png",
  "images/night.png",
  "images/night.png",
  "images/octo.png",
  "images/octo.png",
  "images/peacock.png",
  "images/peacock.png",
  "images/rabbit.png",
  "images/rabbit.png",
  "images/rain.png",
  "images/rain.png",
  "images/rainbow.png",
  "images/rainbow.png",
  "images/seahorse.png",
  "images/seahorse.png",
  "images/shark.png",
  "images/shark.png",
  "images/star.png",
  "images/star.png",
  "images/sun.png",
  "images/sun.png",
  "images/whale.png",
  "images/whale.png",
  "images/wolf.png",
  "images/wolf.png",
  "images/zoo.png",
  "images/zoo.png"  ];
}

List<Detalles> botones =[
  Detalles("Facil",
      Colors.green,
      Colors.green[200],
      const Tablero(Nivel.facil)),
  Detalles("Medio",
      Colors.yellow,
      Colors.yellow[200],
      const Tablero(Nivel.medio)),
  Detalles("Dificil",
      Colors.orange,
      Colors.orange[200],
      const Tablero(Nivel.dificil)),
  Detalles("Imposible",
      Colors.red,
      Colors.red[200],
      const Tablero(Nivel.imposible)),
];

List<String> baraja =[];
List<FlipCardController> controles =[];
List<bool> estados = [];


void barajar(Nivel nivel){
  int size =0;

  switch(nivel){
    case Nivel.facil:
      size =16;
      break;
    case Nivel.medio:
      size =24;
      break;
    case Nivel.dificil:
      size =32;
      break;
    case Nivel.imposible:
      size =36;
      break;
  }
  Gsize = size/2;
  for(int i=0;i<size;i++){
    controles.add(FlipCardController());
    estados.add(true);
  }
  baraja = cards().sublist(0,size);
  baraja.shuffle();
}

String formatElapsedTime(Duration duration) {
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return

    "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
}
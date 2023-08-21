import 'package:flutter/material.dart';

Widget footer(double blockHorizontal, double blockVertical, bool state) {
  return AnimatedContainer(
    margin: EdgeInsets.only(
      left: (!state)?blockHorizontal * 17:blockHorizontal * 7,
      bottom: blockVertical * 1,
      right: blockVertical * 1),
    duration: const Duration(milliseconds: 500),
    height: blockVertical * 5,
    width: blockHorizontal * 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(blockVertical * 1),
      gradient: const LinearGradient(
          colors: [Colors.black26, Colors.black45],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
    ),
    child: Center(
      child: Text(
        "Copyright PT. Cerita Rasa 2023",
        style: TextStyle(color: Colors.white, fontSize: blockVertical * 2),
      ),
    ),
  );
}

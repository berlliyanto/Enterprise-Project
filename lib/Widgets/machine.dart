// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/Widgets/button_material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget Machine(
    double blockHorizontal,
    double blockVertical,
    String title,
    String images,
    String statusBenda,
    String namaSensor,
    String namaSensor2,
    String sensorStatus,
    String sensorStatus2,
    String namaKontroller,
    String motorStatus,
    Color colorStatus,
    Color colorKontrollerStatus,
    VoidCallback ontap,
    bool stateButton) {
  return SizedBox(
    height: blockVertical * 85,
    width: blockHorizontal * 23,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black54,
                fontSize: blockVertical * 5,
                fontWeight: FontWeight.bold),
          ),
          Animate(
            child: Container(
              margin: EdgeInsets.all(blockVertical * 1),
              height: blockHorizontal * 20,
              width: blockHorizontal * 20,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image:
                      DecorationImage(image: AssetImage("../assets/$images.png"))),
            ),
          ).fade(),
          SizedBox(
            height: blockVertical * 1.5,
          ),
          Row(
            children: [
              Text("Status benda : $statusBenda",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: blockVertical * 3,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: blockVertical * 1.5,
          ),
          Row(
            children: [
              Text(namaSensor,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: blockVertical * 3,
                      fontWeight: FontWeight.bold)),
              ClipOval(
                child: Container(
                  height: blockVertical * 2,
                  width: blockVertical * 2,
                  color: colorStatus,
                ),
              ),
              Text(" $sensorStatus",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: blockVertical * 3,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: blockVertical * 1.5,
          ),
          Row(
            children: [
              Text(namaSensor2,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: blockVertical * 3,
                      fontWeight: FontWeight.bold)),
              Text(sensorStatus2,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: blockVertical * 3,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: blockVertical * 1.5,
          ),
          Row(
            children: [
              Text("$namaKontroller Status : ",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: blockVertical * 3,
                      fontWeight: FontWeight.bold)),
              ClipOval(
                child: Container(
                  height: blockVertical * 2,
                  width: blockVertical * 2,
                  color: colorKontrollerStatus,
                ),
              ),
              Text(" $motorStatus",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: blockVertical * 3,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: blockVertical * 3,
          ),
          (!stateButton)?buttonMaterial(
            blockVertical * 6,
            blockHorizontal * 10,
            blockVertical * 3,
            "Nyalakan",
            const Color.fromARGB(255, 48, 243, 48),
            const Color.fromARGB(255, 0, 136, 29),
            const Color.fromARGB(255, 0, 109, 24),
            const Color.fromARGB(255, 9, 63, 21),
            ontap,
          ):buttonMaterial(
            blockVertical * 6,
            blockHorizontal * 10,
            blockVertical * 3,
            "Matikan",
            const Color.fromARGB(255, 243, 48, 48),
            const Color.fromARGB(255, 136, 0, 0),
            const Color.fromARGB(255, 109, 4, 0),
            const Color.fromARGB(255, 63, 9, 9),
            ontap,
          )
        ],
      ),
    ),
  );
}

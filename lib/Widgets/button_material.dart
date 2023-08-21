import 'package:flutter/material.dart';

Widget buttonMaterial(double height, double width, double fontSize,
    String title, Color hover, Color highlight, Color begin, Color end, VoidCallback onTap) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [begin, end],
        ),
      ),
      child: Material(
        type: MaterialType.canvas,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          highlightColor: highlight,
          hoverColor: hover,
          radius: 100,
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
  );
}
//
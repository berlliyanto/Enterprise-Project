// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget sidebarMenu(BoxConstraints constraints, IconData icon, String title,
    Color aktif, Color Nonaktif, VoidCallback onPressed, bool state) {
  return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 50),
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          top: constraints.maxHeight * 0.01, left: constraints.maxWidth * 0.2),
      padding: EdgeInsets.all(constraints.maxHeight * 0.005),
      height: constraints.maxHeight * 0.1,
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(constraints.maxHeight * 0.02),
          bottomLeft: Radius.circular(constraints.maxHeight * 0.02),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: constraints.maxHeight * 0.03,
          color: (state == true)
              ? const Color.fromARGB(255, 0, 163, 228)
              : Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
              color: (state == true)
                  ? const Color.fromARGB(255, 0, 163, 228)
                  : Colors.white,
              fontSize: constraints.maxHeight * 0.025),
        ),
        onTap: onPressed,
        hoverColor: Colors.grey,
      ));
}

Widget collapseSidebarMenu(BoxConstraints constraints, IconData icon,
    Color aktif, Color Nonaktif, VoidCallback onPressed, bool state) {
  return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 50),
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: constraints.maxHeight * 0.01),
      padding: EdgeInsets.all(constraints.maxHeight * 0.005),
      height: constraints.maxHeight * 0.1,
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(constraints.maxHeight * 0.02),
          bottomLeft: Radius.circular(constraints.maxHeight * 0.02),
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: constraints.maxHeight * 0.03,
          color: (state == true)
              ? const Color.fromARGB(255, 0, 163, 228)
              : Colors.white,
        ),
      ));
}
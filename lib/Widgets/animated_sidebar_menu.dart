import 'package:flutter/material.dart';

Widget animatedSidebarMenu(BoxConstraints constraints, Color colors, double positioned) {
  return AnimatedPositioned(
    curve: Curves.easeIn,
    left: constraints.maxWidth*0.28,
    top: constraints.maxHeight*positioned,
    duration: const Duration(milliseconds: 200),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      height: constraints.maxHeight*0.08,
      width: constraints.minWidth*0.75,
      decoration: BoxDecoration(
      color: colors,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(constraints.maxHeight * 0.02),
        bottomLeft: Radius.circular(constraints.maxHeight * 0.02),
      ),
      ),
    ),);
}

Widget animatedSidebarMenuCollapse(BoxConstraints constraints, Color colors, double positioned) {
  return AnimatedPositioned(
    curve: Curves.easeIn,
    top: constraints.maxHeight*positioned,
    duration: const Duration(milliseconds: 200),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      height: constraints.maxHeight*0.08,
      width: constraints.minWidth,
      decoration: BoxDecoration(
      color: colors,
      ),
    ),);
}

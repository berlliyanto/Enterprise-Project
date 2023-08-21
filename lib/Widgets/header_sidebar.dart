import 'package:flutter/material.dart';

Widget headerSidebar(
    BoxConstraints constraints, String name, String level, bool state) {
  return Container(
    padding: EdgeInsets.only(left: (state)?constraints.maxWidth * 0.05 : 0),
    alignment: (state) ? Alignment.centerLeft : Alignment.center,
    height: constraints.maxHeight * 0.15,
    width: constraints.maxWidth,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(constraints.maxHeight * 0.02),
            topRight: Radius.circular(constraints.maxHeight * 0.02)),
        color: Colors.black12),
    child: (state)
        ? SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: constraints.maxHeight * 0.03,
                  child: const Icon(Icons.person),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.05,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: constraints.maxHeight * 0.02),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    Text(
                      level,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: constraints.maxHeight * 0.015),
                    ),
                  ],
                )
              ],
            ),
        )
        : CircleAvatar(
            radius: constraints.maxHeight * 0.03,
            child: const Icon(Icons.person),
          ),
  );
}

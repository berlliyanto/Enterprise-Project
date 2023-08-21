// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names, must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/constant.dart';

class navbar extends StatefulWidget {
  bool state;
  navbar({required this.state,super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(
          (widget.state)?blockHorizontal * 7:blockHorizontal * 17, blockVertical * 1, blockVertical * 1, 0),
      height: blockVertical * 10,
      width: MediaQuerywidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(blockVertical * 2),
        gradient: const LinearGradient(
          colors: [Colors.black54, Colors.black45],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: blockHorizontal * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: blockVertical*6,
                  width: blockVertical*6,
                  child: Image.asset('../assets/logo.png'),
                ),
                Text(
                  "    Admin Panel",
                  style:
                      TextStyle(color: Colors.white, fontSize: blockVertical * 4),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: blockHorizontal * 1, bottom: blockVertical * 0.5),
            child: IconButton(
              onPressed: () {
                AwesomeDialog(
                  width: blockHorizontal*30,
                  context: context,
                  dialogType: DialogType.question,
                  title: "Apakah Anda Yakin Akan Keluar?",
                  useRootNavigator: true,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    Navigator.pushReplacementNamed(context, myLogin);
                  },
                ).show();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: blockVertical * 4,
              ),
            ),
          )
        ],
      ),
    );
  }
}


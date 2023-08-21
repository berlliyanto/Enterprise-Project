// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/Services/login_service.dart';
import 'package:flutter_admin_ena/Widgets/button_material.dart';
import 'package:flutter_admin_ena/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _showpass = true;
  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('../assets/rainy.jpg'),fit: BoxFit.cover),
          gradient: LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: blockHorizontal * 30,
                height: blockVertical * 65,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    //blurEffect
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                      child: Container(),
                    ),
                    Container(
                      padding: EdgeInsets.all(blockVertical * 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.13),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.5)
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: blockVertical * 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login,
                                size: blockVertical * 10,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: blockVertical * 2,
                                bottom: blockVertical * 2),
                            height: blockVertical * 10,
                            width: blockHorizontal * 30,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "CRPanel",
                                  style: TextStyle(
                                      fontSize: blockVertical * 4,
                                      color: Colors.white),
                                ),
                                Text(
                                  "PT. Cerita Rasa",
                                  style: TextStyle(
                                      fontSize: blockVertical * 4,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Input Username",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQueryheight * 0.02,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: blockVertical * 1,
                          ),
                          //EMAIL---------------------------------------------------------------------------
                          Container(
                            alignment: Alignment.centerLeft,
                            height: MediaQueryheight * 0.08,
                            width: MediaQuerywidth,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              border: Border.all(
                                color: Colors.blueGrey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.05),
                                  offset: const Offset(2, 2),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: username,
                              style: TextStyle(
                                  fontSize: MediaQueryheight * 0.021),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                prefixIcon: Icon(
                                  Icons.person_rounded,
                                  size: MediaQueryheight * 0.035,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQueryheight * 0.01,
                          ),
                          Text(
                            "Input Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQueryheight * 0.02,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: blockVertical * 1,
                          ),
                          // Password----------------------------------------------------------------------------------------------------------------
                          Container(
                            alignment: Alignment.centerLeft,
                            height: MediaQueryheight * 0.08,
                            width: MediaQuerywidth,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              border: Border.all(
                                color: Colors.blueGrey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.05),
                                  offset: const Offset(2, 2),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: password,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  fontSize: MediaQueryheight * 0.021),
                              obscureText: _showpass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: MediaQueryheight * 0.035,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showpass = !_showpass;
                                    });
                                  },
                                  icon: Icon(
                                    _showpass
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: MediaQueryheight * 0.035,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: blockVertical * 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buttonMaterial(
                                blockVertical * 6,
                                blockHorizontal * 10,
                                blockVertical * 3,
                                "LOGIN",
                                const Color.fromARGB(255, 48, 84, 243),
                                const Color.fromARGB(255, 0, 9, 136),
                                const Color.fromARGB(255, 0, 34, 109),
                                const Color.fromARGB(255, 9, 19, 63),
                                () {
                                 LoginService()
                                      .login(username.text, password.text)
                                      .then(
                                    (value) {
                                      if (value != null) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => dashboard(
                                              name: value['username'],
                                              level: value['level'],
                                            ),
                                          ),
                                        );
                                      } else {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                title:
                                                    "Password atau Username Salah!",
                                                useRootNavigator: true,
                                                autoHide:
                                                    const Duration(seconds: 2),
                                                width: blockHorizontal * 20,
                                                bodyHeaderDistance:
                                                    blockVertical * 30)
                                            .show();
                                      }
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget LogoLoginPage(
      double MediaQueryheight, double blockHorizontal, double blockVertical) {
    return Container(
      height: MediaQueryheight,
      width: blockHorizontal * 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 246, 246),
        borderRadius: BorderRadius.only(topRight: Radius.circular(blockVertical*3), bottomRight: Radius.circular(blockVertical*3)),
      ),
      child: Center(
        child: SizedBox(
          height: blockVertical*70,
          width: blockVertical*70,
          child: Image.asset('../assets/logo.png'),
        ),
      )
    );
  }
}

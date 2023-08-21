// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/Pages/account_page.dart';
import 'package:flutter_admin_ena/Pages/dashboard_page.dart';
import 'package:flutter_admin_ena/Pages/machine_page.dart';
import 'package:flutter_admin_ena/Pages/order_page.dart';
import 'package:flutter_admin_ena/Pages/stock_page.dart';
import 'package:flutter_admin_ena/Widgets/animated_sidebar_menu.dart';
import 'package:flutter_admin_ena/Widgets/footer.dart';
import 'package:flutter_admin_ena/Widgets/header_sidebar.dart';
import 'package:flutter_admin_ena/Widgets/navbar.dart';
import 'package:flutter_admin_ena/Widgets/sidebar.dart';

class dashboard extends StatefulWidget {
  String? name, level;
  dashboard({required this.name, required this.level, super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int stateActive = 0;
  bool sidebarCollapse = false;
  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: (stateActive == 0)
                ? const Color.fromARGB(255, 225, 225, 225)
                : (stateActive == 1)
                    ? const Color.fromARGB(255, 190, 190, 190)
                    : (stateActive == 2)
                        ? const Color.fromARGB(255, 155, 155, 155)
                        : (stateActive == 3)
                            ? const Color.fromARGB(255, 120, 120, 120)
                            : const Color.fromARGB(255, 85, 85, 85)),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //NAVBAR
                navbar(
                  state: (sidebarCollapse) ? true : false,
                ),
                //FOOTER
                footer(blockHorizontal, blockVertical,
                    (sidebarCollapse) ? true : false)
              ],
            ),
            //SIDEBAR
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: EdgeInsets.all(blockVertical * 1),
              height: blockVertical * 100,
              width: (!sidebarCollapse)
                  ? blockHorizontal * 16
                  : blockHorizontal * 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(blockVertical * 2),
                gradient: const LinearGradient(
                    colors: [Color.fromARGB(118, 0, 0, 0), Colors.black26],
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  const Color.fromARGB(255, 116, 116, 116)
                                      .withOpacity(0.8),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    sidebarCollapse = !sidebarCollapse;
                                  });
                                },
                                icon: Icon(
                                  (!sidebarCollapse)
                                      ? Icons.keyboard_arrow_left_sharp
                                      : Icons.keyboard_arrow_right_sharp,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            )
                          ],
                        ),
                      ),
                      (!sidebarCollapse)
                          ? animatedSidebarMenu(
                              constraints,
                              (stateActive == 0)
                                  ? const Color.fromARGB(255, 65, 65, 65).withOpacity(0.5)
                                  : (stateActive == 1)
                                      ? const Color.fromARGB(255, 87, 87, 87).withOpacity(0.5)
                                      : (stateActive == 2)
                                          ? const Color.fromARGB(
                                              255, 155, 155, 155).withOpacity(0.5)
                                          : (stateActive == 3)
                                              ? const Color.fromARGB(
                                                  255, 190, 190, 190).withOpacity(0.5)
                                              : const Color.fromARGB(
                                                  255, 225, 225, 225).withOpacity(0.5),
                              (stateActive == 0)
                                  ? 0.17
                                  : (stateActive == 1)
                                      ? 0.28
                                      : (stateActive == 2)
                                          ? 0.39
                                          : (stateActive == 3)
                                              ? 0.50
                                              : 0.61)
                          : animatedSidebarMenuCollapse(
                              constraints,
                              (stateActive == 0)
                                  ? const Color.fromARGB(255, 65, 65, 65).withOpacity(0.5)
                                  : (stateActive == 1)
                                      ? const Color.fromARGB(255, 87, 87, 87).withOpacity(0.5)
                                      : (stateActive == 2)
                                          ? const Color.fromARGB(
                                              255, 155, 155, 155).withOpacity(0.5)
                                          : (stateActive == 3)
                                              ? const Color.fromARGB(
                                                  255, 190, 190, 190).withOpacity(0.5)
                                              : const Color.fromARGB(
                                                  255, 225, 225, 225).withOpacity(0.5),
                              (stateActive == 0)
                                  ? 0.17
                                  : (stateActive == 1)
                                      ? 0.28
                                      : (stateActive == 2)
                                          ? 0.39
                                          : (stateActive == 3)
                                              ? 0.50
                                              : 0.61),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headerSidebar(
                              constraints,
                              "${widget.name}",
                              "${widget.level}",
                              (!sidebarCollapse) ? true : false),
                          (!sidebarCollapse)
                              ? sidebarMenu(
                                  constraints,
                                  Icons.location_city,
                                  "Enterprise",
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 0;
                                  });
                                }, (stateActive == 0) ? true : false)
                              : collapseSidebarMenu(
                                  constraints,
                                  Icons.home,
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 0;
                                  });
                                }, (stateActive == 0) ? true : false),
                          (!sidebarCollapse)
                              ? sidebarMenu(
                                  constraints,
                                  Icons.shop,
                                  "Order",
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 1;
                                  });
                                }, (stateActive == 1) ? true : false)
                              : collapseSidebarMenu(
                                  constraints,
                                  Icons.shop,
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 1;
                                  });
                                }, (stateActive == 1) ? true : false),
                          (!sidebarCollapse)
                              ? sidebarMenu(
                                  constraints,
                                  Icons.add_box,
                                  "Stock",
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 2;
                                  });
                                }, (stateActive == 2) ? true : false)
                              : collapseSidebarMenu(
                                  constraints,
                                  Icons.add_box,
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 2;
                                  });
                                }, (stateActive == 2) ? true : false),
                          (!sidebarCollapse)
                              ? sidebarMenu(
                                  constraints,
                                  Icons.precision_manufacturing,
                                  "Monitoring",
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 3;
                                  });
                                }, (stateActive == 3) ? true : false)
                              : collapseSidebarMenu(
                                  constraints,
                                  Icons.precision_manufacturing,
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 3;
                                  });
                                }, (stateActive == 3) ? true : false),
                          // (widget.level == "Admin")
                          //     ?
                          (!sidebarCollapse)
                              ? sidebarMenu(
                                  constraints,
                                  Icons.person,
                                  "Accounts",
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 4;
                                  });
                                }, (stateActive == 4) ? true : false)
                              : collapseSidebarMenu(
                                  constraints,
                                  Icons.person,
                                  const Color.fromARGB(255, 92, 92, 92),
                                  Colors.transparent, () {
                                  setState(() {
                                    stateActive = 4;
                                  });
                                }, (stateActive == 4) ? true : false)

                          // : const SizedBox(
                          //     height: 1,
                          //   ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            //MAIN CONTENT
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: EdgeInsets.only(
                  top: blockVertical * 12,
                  left: (!sidebarCollapse)
                      ? blockHorizontal * 17
                      : blockHorizontal * 7),
              padding: EdgeInsets.all(blockVertical * 1),
              height: blockVertical * 81,
              width: (!sidebarCollapse)
                  ? blockHorizontal * 82.5
                  : blockHorizontal * 92.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(blockVertical * 1),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return (stateActive == 0)
                      ? dashboardPage(constraints: constraints)
                      : (stateActive == 1)
                          ? OrderPage(constraints: constraints)
                          : (stateActive == 2)
                              ? StockPage(constraints: constraints)
                              : (stateActive == 3)
                                  ? machinePage(constraints: constraints)
                                  : accountsPage(constraints: constraints);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

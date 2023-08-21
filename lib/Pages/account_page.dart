// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/Pages/addAccounts_page.dart';
import 'package:flutter_admin_ena/Services/user_service.dart';
import 'package:flutter_admin_ena/models/user_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class accountsPage extends StatefulWidget {
  BoxConstraints constraints;

  accountsPage({required this.constraints, super.key});

  @override
  State<accountsPage> createState() => _accountsPageState();
}

class _accountsPageState extends State<accountsPage> {
  int state = 0;
  late Timer timer;
  StreamController streamUser = StreamController.broadcast();
  UserService getUserAll = UserService();
  List<userModel> listUser = [];
  Future<void> userData() async {
    listUser = await getUserAll.getUser();
    streamUser.add(listUser);
  }

  @override
  void initState() {
    userData();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      userData();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double blockHorizontal = widget.constraints.maxWidth / 100;
    double blockVertical = widget.constraints.maxHeight / 100;
    return (state == 0)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: blockHorizontal * 2, top: blockVertical * 2),
                    child: Text(
                      "Accounts",
                      style: TextStyle(
                          color: Colors.black54, fontSize: blockVertical * 4),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: blockVertical * 2),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            state = 1;
                          });
                        },
                        child: Icon(
                          Icons.person_add,
                          size: blockVertical * 4,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              Divider(
                thickness: blockVertical * 1,
                indent: blockHorizontal * 1,
                endIndent: blockHorizontal * 88,
              ),
              SizedBox(
                height: blockVertical * 2,
              ),
              Container(
                height: blockVertical * 86,
                width: blockHorizontal * 100,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: StreamBuilder(
                    stream: streamUser.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> state) {
                                return Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.5);
                              }),
                              border: TableBorder(
                                top: BorderSide(
                                    width: blockVertical * 0.2,
                                    color: Colors.black.withOpacity(0.3)),
                                left: BorderSide(
                                    width: blockVertical * 0.2,
                                    color: Colors.black.withOpacity(0.3)),
                                right: BorderSide(
                                    width: blockVertical * 0.2,
                                    color: Colors.black.withOpacity(0.3)),
                                bottom: BorderSide(
                                    width: blockVertical * 0.2,
                                    color: Colors.black.withOpacity(0.3)),
                                borderRadius:
                                    BorderRadius.circular(blockVertical * 2),
                                verticalInside: BorderSide(
                                  width: blockVertical * 0.2,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                horizontalInside: BorderSide(
                                  width: 3,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(blockVertical * 3)),
                              columns: [
                                DataColumn(
                                    label: Text(
                                  "No",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Username",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Password",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Level",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Actions",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                              ],
                              rows: listUser.map((e) {
                                int index = listUser.indexOf(e);
                                String Number = (index + 1)
                                    .toString()
                                    .padLeft(listUser.length.toString().length);
                                return DataRow(cells: [
                                  DataCell(
                                    SelectableText(
                                      Number,
                                      style: TextStyle(
                                        fontSize: blockVertical * 3,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SelectableText(
                                      "${e.username}",
                                      style: TextStyle(
                                        fontSize: blockVertical * 3,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SelectableText(
                                      "${e.password}",
                                      style: TextStyle(
                                        fontSize: blockVertical * 3,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SelectableText(
                                      "${e.level}",
                                      style: TextStyle(
                                        fontSize: blockVertical * 3,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  DataCell((e.level!="Admin")?Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit,
                                            size: blockVertical * 3,
                                            color: Colors.amber,
                                          )),
                                      IconButton(
                                        onPressed: () {
                                          DeleteUserService.deleteUser(
                                              e.id!);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: blockVertical * 3,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ):const SizedBox()),
                                ]);
                              }).toList()),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: LoadingAnimationWidget.bouncingBall(color: Colors.red, size: blockVertical*6));
                      }
                      return Center(
                        child: Text(
                          "NO DATA",
                          style: TextStyle(fontSize: blockVertical * 5),
                        ),
                      );
                    }),
              )
            ],
          )
        : addAkun(
            constraints: widget.constraints,
            ubahState: () {
              setState(() {
                state = 0;
              });
            },
          );
  }
}

// buttonMaterial(
//     blockVertical * 5,
//     blockHorizontal * 5,
//     blockVertical * 2,
//     "Ubah",
//     const Color.fromARGB(255, 241, 244, 54),
//     const Color.fromARGB(255, 252, 255, 82),
//     const Color.fromARGB(255, 244, 231, 54),
//     const Color.fromARGB(255, 231, 244, 54), () {
// }),
// buttonMaterial(
//     blockVertical * 5,
//     blockHorizontal * 5,
//     blockVertical * 2,
//     "Hapus",
//     Colors.red,
//     Colors.redAccent,
//     Colors.red,
//     Colors.red, () {
//       DeleteUserService.deleteUser(int.parse(e.id!));
// }),
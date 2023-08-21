// ignore_for_file: camel_case_types, must_be_immutable, unnecessary_null_comparison, file_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_admin_ena/Services/user_service.dart';
import 'package:flutter_admin_ena/Widgets/button_material.dart';

class addAkun extends StatefulWidget {
  BoxConstraints constraints;
  VoidCallback? ubahState;
  addAkun({required this.constraints, this.ubahState, super.key});

  @override
  State<addAkun> createState() => _addAkunState();
}

class _addAkunState extends State<addAkun> {
  List<String> listlevel = ["Admin", "Supervisi", "Operator"];
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController level = TextEditingController();
  String? levelValue;
  @override
  Widget build(BuildContext context) {
    double blockHorizontal = widget.constraints.maxWidth / 100;
    double blockVertical = widget.constraints.maxHeight / 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: blockHorizontal * 2, top: blockVertical * 2),
          child: Text(
            "Tambah Akun",
            style:
                TextStyle(color: Colors.black54, fontSize: blockVertical * 4),
          ),
        ),
        Divider(
          thickness: blockVertical * 1,
          indent: blockHorizontal * 1,
          endIndent: blockHorizontal * 85,
        ),
        SizedBox(
          height: blockVertical * 2,
        ),
        Container(
          height: blockVertical * 84,
          width: blockHorizontal * 100,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textfield(blockHorizontal, blockVertical, username, "username",
                  Icons.person),
              SizedBox(
                height: blockVertical * 2,
              ),
              textfield(blockHorizontal, blockVertical, password, "password",
                  Icons.password),
              SizedBox(
                height: blockVertical * 2,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: blockHorizontal * 5),
                height: blockVertical * 10,
                width: blockHorizontal * 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(blockVertical * 5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: blockVertical * 0.1,
                      horizontal: blockHorizontal * 1),
                  child: DropdownSearch<String>(
                      clearButtonProps: const ClearButtonProps(
                        isVisible: true,
                      ),
                      popupProps: PopupProps.menu(
                        constraints:
                            BoxConstraints(maxHeight: blockVertical * 30),
                        showSelectedItems: true,
                        disabledItemFn: (String s) => s.startsWith('A'),
                      ),
                      items: listlevel,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Pilih Level",
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          levelValue = value;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: blockVertical * 4,
              ),
              buttonMaterial(
                blockVertical * 7,
                blockHorizontal * 30,
                blockVertical * 3,
                "Tambah Akun",
                const Color.fromARGB(255, 72, 255, 0),
                const Color.fromARGB(255, 50, 109, 2),
                const Color.fromARGB(255, 75, 133, 0),
                const Color.fromARGB(255, 128, 109, 0),
                () {
                  if(username.text == null || password.text == null || nama.text == null || levelValue == null){
                    AwesomeDialog(
                          context: context,
                          width: blockHorizontal * 30,
                          dialogType: DialogType.warning,
                          title: "Gagal Masukan Data, Form Kosong",
                          btnOkOnPress: () {},
                          useRootNavigator: true,
                        ).show();
                  }
                  InsertUserService.insertUser(
                          username.text, password.text, levelValue!)
                      .then(
                    (value) {
                      if (value == true) {
                        AwesomeDialog(
                          context: context,
                          width: blockHorizontal * 30,
                          dialogType: DialogType.success,
                          title: "Sukses Masukan Data",
                          btnOkOnPress: () {},
                          useRootNavigator: true,
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          width: blockHorizontal * 30,
                          dialogType: DialogType.error,
                          title: "Gagal Masukan Data",
                          btnOkOnPress: () {},
                          useRootNavigator: true,
                        ).show();
                      }
                    },
                  );
                },
              ),
              SizedBox(height: blockVertical*20,),
              ElevatedButton(onPressed: widget.ubahState, child: Text("KEMBALI", style: TextStyle(fontSize: blockVertical*3, ),))
            ],
          ),
        ),
      ],
    );
  }
}
//

Widget textfield(double blockHorizontal, double blockVertical,
    TextEditingController controller, String hintetxt, IconData icons) {
  return Container(
    alignment: Alignment.centerLeft,
    height: blockVertical * 8,
    width: blockHorizontal * 50,
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
      controller: controller,
      style: TextStyle(fontSize: blockVertical * 2.1),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintetxt,
        prefixIcon: Icon(
          icons,
          size: blockVertical * 3.5,
        ),
      ),
    ),
  );
}

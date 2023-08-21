// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/Services/activities_zoho.dart';
import 'package:flutter_admin_ena/Services/prospek_zoho.dart';
import 'package:flutter_admin_ena/Services/vendors_zoho.dart';
import 'package:flutter_admin_ena/horizontal_scroll.dart';
import 'package:flutter_admin_ena/models/activities_model.dart';
import 'package:flutter_admin_ena/models/prospekZoho_model.dart';
import 'package:flutter_admin_ena/models/vendors_model.dart';
import 'package:get/get.dart';

class dashboardPage extends StatefulWidget {
  BoxConstraints constraints;
  dashboardPage({required this.constraints, super.key});

  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
  int stateDash = 0;
  late Timer timer;
  StreamController streamLeads = StreamController.broadcast();
  List<LeadModel> listLeads = [];
  GetProspek getProspek = GetProspek();
  Future<void> leadsData() async {
    listLeads = await getProspek.fetchLeads();
    streamLeads.add(listLeads);
  }

  StreamController streamVendors = StreamController.broadcast();
  List<VendorModel> listVendors = [];
  GetVendors getVendors = GetVendors();
  Future<void> VendorsData() async {
    listVendors = await getVendors.vendorsData();
    streamVendors.add(listVendors);
  }

  StreamController streamActivites = StreamController.broadcast();
  List<ActivitiesModel> listActivites = [];
  GetActivites getActivities = GetActivites();
  Future<void> ActivitesData() async {
    listActivites = await getActivities.activitiesData();
    streamActivites.add(listActivites);
  }

  @override
  void initState() {
    VendorsData();
    ActivitesData();
    leadsData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      VendorsData();
      ActivitesData();
      leadsData();
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
    return GetMaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
              bodyLarge: TextStyle(decoration: TextDecoration.none))),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      scrollBehavior: ScrollHorizontal(),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: blockHorizontal * 2, top: blockVertical * 2),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        stateDash = 0;
                      });
                    },
                    child: Text(
                      "Prospek",
                      style: TextStyle(
                          color:
                              (stateDash == 0) ? Colors.blue : Colors.black54,
                          fontSize: blockVertical * 4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: blockHorizontal * 2, top: blockVertical * 2),
                  child: GestureDetector(
                    onTap: () {
                      GetActivites().activitiesData;
                      setState(() {
                        stateDash = 1;
                      });
                    },
                    child: Text(
                      "Aktivitas",
                      style: TextStyle(
                          color:
                              (stateDash == 1) ? Colors.blue : Colors.black54,
                          fontSize: blockVertical * 4),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: blockHorizontal * 2, top: blockVertical * 2),
                  child: GestureDetector(
                    onTap: () {
                      GetActivites().activitiesData;
                      setState(() {
                        stateDash = 2;
                      });
                    },
                    child: Text(
                      "Vendors",
                      style: TextStyle(
                          color:
                              (stateDash == 2) ? Colors.blue : Colors.black54,
                          fontSize: blockVertical * 4),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: blockVertical * 2,
            ),
            Container(
              height: blockVertical * 86,
              width: blockHorizontal * 100,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: (stateDash == 0)
//====================================================PROSPEK==========================================================================//
                  ? StreamBuilder(
                      stream: streamLeads.stream,
                      builder: (context, snapshot) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> state) {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
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
                                  "Id",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Full Name",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                              ],
                              rows: listLeads.map((e) {
                                int index = listLeads.indexOf(e);
                                String Number = (index + 1).toString().padLeft(
                                    listLeads.length.toString().length);
                                return DataRow(cells: [
                                  DataCell(Text(Number)),
                                  DataCell(Text("${e.id}")),
                                  DataCell(
                                      Text("${e.firstName} ${e.lastName}")),
                                  DataCell(Text("${e.email}")),
                                ]);
                              }).toList()),
                        );
                      })
//====================================================ACTIVITIES==========================================================================//
                  : (stateDash==1)?StreamBuilder(
                      stream: streamLeads.stream,
                      builder: (context, snapshot) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> state) {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
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
                                  "Name",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Tenggat",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Tugas",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Prioritas",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Status",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                              ],
                              rows: listActivites.map((e) {
                                int index = listActivites.indexOf(e);
                                String Number = (index + 1).toString().padLeft(
                                    listLeads.length.toString().length);
                                return DataRow(cells: [
                                  DataCell(Text(Number)),
                                  DataCell(Text("${e.name}")),
                                  DataCell(Text("${e.tenggat}")),
                                  DataCell(Text("${e.tugas}")),
                                  DataCell(Text("${e.prioritas}")),
                                  DataCell(Text("${e.status}")),
                                ]);
                              }).toList()),
                        );
//====================================================VENDORS==========================================================================//
                      }):StreamBuilder(
                      stream: streamLeads.stream,
                      builder: (context, snapshot) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> state) {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
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
                                  "Vendor Name",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Website",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Phone",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                                DataColumn(
                                    label: Text(
                                  "Name",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical * 4),
                                )),
                              ],
                              rows: listVendors.map((e) {
                                int index = listVendors.indexOf(e);
                                String Number = (index + 1).toString().padLeft(
                                    listLeads.length.toString().length);
                                return DataRow(cells: [
                                  DataCell(Text(Number)),
                                  DataCell(Text("${e.vendorName}")),
                                  DataCell(Text("${e.email}")),
                                  DataCell(Text("${e.website}")),
                                  DataCell(Text("${e.phone}")),
                                  DataCell(Text("${e.name}")),
                                ]);
                              }).toList()),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

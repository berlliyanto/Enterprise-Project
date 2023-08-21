// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/Services/order_service.dart';
import 'package:flutter_admin_ena/models/order_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderPage extends StatefulWidget {
  BoxConstraints constraints;
  OrderPage({required this.constraints, super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Timer timer;
  StreamController streamOrder = StreamController.broadcast();
  OrderService orderService = OrderService();
  List<OrderModel> listOrder = [];
  Future<void> orderData() async {
    listOrder = await orderService.getOrder();
    streamOrder.add(listOrder);
  }

  @override
  void initState() {
    orderData();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      orderData();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: blockHorizontal * 2, top: blockVertical * 2),
          child: Text(
            "Order",
            style:
                TextStyle(color: Colors.black54, fontSize: blockVertical * 4),
          ),
        ),
        Divider(
          thickness: blockVertical * 1,
          indent: blockHorizontal * 1,
          endIndent: blockHorizontal * 92,
        ),
        SizedBox(
          height: blockVertical * 2,
        ),
        Container(
          height: blockVertical * 86,
          width: blockHorizontal * 100,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: StreamBuilder(
              stream: streamOrder.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                        borderRadius: BorderRadius.circular(blockVertical * 2),
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
                              fontSize: blockVertical *2.5,
                              fontWeight: FontWeight.bold),
                        )),
                        // DataColumn(
                        //     label: Text(
                        //   "id",
                        //   style: TextStyle(
                        //       color: Colors.black45,
                        //       fontSize: blockVertical *2.5,
                        //        fontWeight: FontWeight.bold),
                        // )),
                        DataColumn(
                            label: Text(
                          "Tanggal",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: blockVertical *2.5,
                               fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Nama",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: blockVertical *2.5,
                               fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Alamat",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: blockVertical *2.5,
                               fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: blockVertical *2.5,
                               fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Produk",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: blockVertical *2.5,
                               fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Jumlah",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: blockVertical *2.5,
                               fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Total",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: blockVertical *2.5,
                               fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Status",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: blockVertical *2.5,
                               fontWeight: FontWeight.bold),
                        )),
                      ],
                      rows: listOrder.map(
                        (e) {
                          int index = listOrder.indexOf(e);
                          String number = (index + 1)
                              .toString()
                              .padLeft(listOrder.length.toString().length);
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  number,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical *2.5),
                                ),
                              ),
                              // DataCell(
                              //   Container(
                              //     color: Colors.transparent,
                              //     width: blockHorizontal*6,
                              //     child: Text(
                              //       e.id!,
                              //       style: TextStyle(
                              //           overflow: TextOverflow.ellipsis,
                              //           color: Colors.black45,
                              //           fontSize: blockVertical *2.5),
                              //     ),
                              //   ),
                              // ),
                              DataCell(
                                Text(
                                  e.tanggal!,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical *2.5),
                                ),
                              ),
                              DataCell(
                                Text(
                                  e.namaPembeli!,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical *2.5),
                                ),
                              ),
                              DataCell(
                                Text(
                                  e.alamat!,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical *2.5),
                                ),
                              ),
                              DataCell(
                                Text(
                                  e.email!,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical *2.5),
                                ),
                              ),
                              DataCell(
                                Text(
                                  e.produk!,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical *2.5),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${e.jumlah}",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical *2.5),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "${e.total}",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: blockVertical *2.5),
                                ),
                              ),
                              DataCell((e.state == true)
                                  ? Text(
                                      "Dikirim",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: blockVertical *2.5),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        UpdateStatusOrder.updateOrder(true, e.id!);
                                        UpdateStatusOrder.sendEmail(e.id!, e.email!, e.alamat!, e.produk!, e.jumlah!.toString(), e.total!.toString(), e.namaPembeli!);
                                      },
                                      child: Text(
                                        "Kirim",
                                        style: TextStyle(
                                            fontSize: blockVertical * 2.5),
                                      ))),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: LoadingAnimationWidget.bouncingBall(
                          color: Colors.red, size: blockVertical * 6));
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
    );
  }
}

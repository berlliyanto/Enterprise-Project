// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/Pages/addAccounts_page.dart';
import 'package:flutter_admin_ena/Services/produk_service.dart';
import 'package:flutter_admin_ena/Widgets/button_material.dart';
import 'package:flutter_admin_ena/models/produk_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StockPage extends StatefulWidget {
  BoxConstraints constraints;
  StockPage({required this.constraints, super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late Timer timer;

  TextEditingController controllerRoti1 = TextEditingController();
  TextEditingController controllerRoti2 = TextEditingController();
  TextEditingController controllerRoti3 = TextEditingController();

  StreamController streamProduk = StreamController.broadcast();
  ProdukService produkService = ProdukService();
  List<ProdukModel> listProduk = [];
  Future<void> produkData() async {
    listProduk = await produkService.getProduk();
    streamProduk.add(listProduk);
  }

  @override
  void initState() {
    produkData();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      produkData();
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
            "Stock",
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
          height: blockVertical * 85,
          width: blockHorizontal * 100,
          child: StreamBuilder(
              stream: streamProduk.stream,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: listProduk.map((e) {
                    return cardStock(
                        blockVertical,
                        blockHorizontal,
                        e.produk!,
                        (e.produk == "Roti Coklat")
                            ? "RotiA.jpg"
                            : (e.produk == "Roti Keju")
                                ? "RotiB.jpg"
                                : "RotiC.jpg",
                        "${e.stok}",
                         (e.produk == "Roti Coklat")
                            ? controllerRoti1
                            : (e.produk == "Roti keju")
                                ? controllerRoti2
                                : controllerRoti3,
                        () {
                          (e.produk == "Roti Coklat")
                            ? TambahStokProduk.updateProduk(int.parse(controllerRoti1.text), e.produk!)
                            : (e.produk == "Roti keju")
                                ? TambahStokProduk.updateProduk(int.parse(controllerRoti2.text), e.produk!)
                                : TambahStokProduk.updateProduk(int.parse(controllerRoti3.text), e.produk!);
                        });
                  }).toList(),
                );
              }),
        )
      ],
    );
  }

  Widget cardStock(
      double blockVertical,
      double blockHorizontal,
      String title,
      String gambar,
      String jumlah,
      TextEditingController controller,
      VoidCallback onTap) {
    return Animate(
      child: Container(
        padding: EdgeInsets.all(blockVertical * 2),
        height: blockVertical * 75,
        width: blockHorizontal * 30,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 206, 206, 206),
          borderRadius: BorderRadius.circular(blockVertical * 1),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              offset: Offset(blockHorizontal * 1, blockHorizontal * 1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: blockVertical * 4,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: blockVertical * 2, bottom: blockVertical * 3),
              height: blockHorizontal * 14,
              width: blockHorizontal * 14,
              child: Image.asset("../assets/$gambar"),
            ),
            Text(
              jumlah,
              style: TextStyle(
                  fontSize: blockVertical * 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: blockVertical * 2, bottom: blockVertical * 5),
              alignment: Alignment.centerLeft,
              height: blockVertical * 7,
              width: blockHorizontal * 15,
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
                style: TextStyle(fontSize: blockVertical * 3.5),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Jumlah",
                  prefixIcon: Icon(
                    Icons.add,
                    size: blockVertical * 3.5,
                  ),
                ),
              ),
            ),
            buttonMaterial(
                blockVertical * 5,
                blockHorizontal * 15,
                blockVertical * 3.5,
                "Tambah Stock",
                Colors.blueAccent,
                Colors.blue,
                Colors.lightBlue,
                Colors.lightBlueAccent,
                onTap)
          ],
        ),
      ),
    ).fade();
  }
}

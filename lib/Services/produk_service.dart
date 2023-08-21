import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_admin_ena/models/produk_model.dart';

import 'package:http/http.dart' as http;

class ProdukService {
  Future getProduk() async {
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/produk");
    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    Iterable it = (json.decode(response.body) as Map<String, dynamic>)['data'];
    List<ProdukModel> getUser = it.map((e) => ProdukModel.FromJSON(e)).toList();
    return getUser;
  }
}

class TambahStokProduk {
  static Future updateProduk(int stok, String produk) async {
    Uri url =
        Uri.parse("https://ena.aplikasipms.com/api/produk?method=tambah");
    var response = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"produk": produk, "stok": stok}));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("OK");
      }
    } else {
      if (kDebugMode) {
        print("Not OK");
      }
    }
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_admin_ena/models/produksi_model.dart';
import 'package:http/http.dart' as http;

class GetProduksiData{
  Future getProduksi()async {
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/produksi");
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json'
    });
    Iterable it = (json.decode(response.body)as Map<String, dynamic>)['data'];
    List<ProduksiModel> listProduksi = it.map((e) => ProduksiModel.FromJSON(e)).toList();
    return listProduksi;
  }
}

class ResetProduksiData{
  static Future resetProduksi()async {
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/produksi");
    var response = await http.put(url,headers:  <String, String>{
      'Content-Type': 'application/json'
    });
    if(response.statusCode==200){
      if (kDebugMode) {
        print("Berhaisl reset");
      }
    }else{
      if (kDebugMode) {
        print("GHagal Reste");
      }
    }
  }
}

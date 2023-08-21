import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_admin_ena/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future getOrder() async {
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/order");
    var response = await http.get(url,
        headers: <String, String>{'Content-Type': 'application/json'});
    Iterable it = (json.decode(response.body) as Map<String, dynamic>)['data'];
    List<OrderModel> getOrder = it.map((e) => OrderModel.FromJSON(e)).toList();
    return getOrder;
  }
}

class UpdateStatusOrder{
  static Future updateOrder(bool state, String id) async {
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/order");
    var response = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({"state": state, "id": id}));
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

  static Future sendEmail(String id, String email, String alamat, String produk,
      String jumlah, String total, String nama) async {
    Uri url = Uri.parse("https://ena.aplikasipms.com/send-email");
    var subject = 'Pesanan Anda Telah Dikirim - $id';
    var text =
        'Halo $nama\n\nKami senang untuk memberitahu Anda bahwa pesanan Anda telah berhasil dikirim dan dalam perjalanan menuju alamat pengiriman yang tertera. Berikut adalah rincian pengiriman pesanan Anda:\n\nDetail Pengiriman:\nNama Penerima: $nama\nAlamat: $alamat\nJenis Produk: $produk\nJumlah Produk: $jumlah\nJumlah yang Harus Dibayarkan: Rp.$total\n\nSalam Hangat PT CERITA RASA';
    var response = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({
          "to": email,
          "subject": subject,
          "text": text,
        }));
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

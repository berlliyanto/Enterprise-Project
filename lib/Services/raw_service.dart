
import 'dart:convert';

import 'package:flutter_admin_ena/models/raw_model.dart';
import 'package:http/http.dart' as http;

class GetRawMaterial{
  Future getRaw()async {
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/raw");
    var response = await http.get(url, headers: <String, String> {
      'Content-Type': 'application/json'
    });
    Iterable it = (json.decode(response.body)as Map<String, dynamic>)['data'];
    List<RawModel> listRaw = it.map((e) => RawModel.FromJSON(e)).toList();
    return listRaw;
  }
}
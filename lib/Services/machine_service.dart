import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_admin_ena/models/machine_model.dart';
import 'package:http/http.dart' as http;

class GetMachineState{
  Future getMachine()async{
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/machine");
    var response = await http.get(url,headers: <String, String>{
      "Content-Type": "application/json"
    });
    Iterable it = (json.decode(response.body)as Map<String, dynamic>)['data'];
    List<MachineModel> listMachine = it.map((e) => MachineModel.FromJSON(e)).toList();
    return listMachine;
  }
}

class UpdateMachine{
  static Future updateMachineMixer(bool mixer)async{
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/machine");
    var response = await http.put(url,headers: <String, String>{
      "Content-Type": "application/json"
    },
    body: jsonEncode({
      "mixer": mixer,
    }) 
    );
    if(response.statusCode==200){
      print("ok");
    }
  }
  static Future updateMachineoven(bool oven)async{
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/machine");
    var response = await http.put(url,headers: <String, String>{
      "Content-Type": "application/json"
    },
    body: jsonEncode({
      "oven": oven,
    }) 
    );
    if(response.statusCode==200){
      print("ok");
    }
  }
  static Future updateMachinepembagi(bool pembagi)async{
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/machine");
    var response = await http.put(url,headers: <String, String>{
      "Content-Type": "application/json"
    },
    body: jsonEncode({
      "pembagi": pembagi,
    }) 
    );
    if(response.statusCode==200){
      print("ok");
    }
  }
  static Future updateMachineproofer(bool proofer)async{
    Uri url = Uri.parse("https://ena.aplikasipms.com/api/machine");
    var response = await http.put(url,headers: <String, String>{
      "Content-Type": "application/json"
    },
    body: jsonEncode({
      "proofer": proofer,
    }) 
    );
    if(response.statusCode==200){
      print("ok");
    }
  }
}
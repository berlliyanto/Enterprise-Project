import 'package:flutter_admin_ena/models/activities_model.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GetActivites{
  Future<List<ActivitiesModel>> activitiesData() async {
    Uri url = Uri.parse("https://www.zohoapis.com/crm/v2/functions/get_activites/actions/execute?auth_type=apikey&zapikey=1003.79761165061eddf2d0ace5e8bda8b44f.7381ab79c9a052b0f0b7b7199e57c7c7");
    var response = await http.get(url);
    var data = json.decode(response.body)['details'];
    var outputs = data['output'];
    List listOutputs = json.decode(outputs);
    List<ActivitiesModel> getActivities = listOutputs.map((e) => ActivitiesModel.FromJSON(e)).toList();
    if (kDebugMode) {
      print(getActivities);
    }
    return getActivities;
  }
}
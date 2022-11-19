import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'cuisines_model.dart';

class CuisinesController extends GetxController{
  var results = <Results>[];

  Future<List<Results>> getCuisinesData({required String cuisine}) async {
    String apiKey = "d8c5f57273584c9198aa22b0462a8f38";
    String baseUrl = "https://api.spoonacular.com/recipes/complexSearch";
    String url = "$baseUrl?cuisine=$cuisine&apiKey=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    try{
      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        var cuisinesMain = CuisinesModel.fromJson(responseBody);
        results = cuisinesMain.results;
      }
    } catch (e){
      print(e);
    }
    return results;
  }
}
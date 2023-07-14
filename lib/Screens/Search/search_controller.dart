

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:async';
import 'search_model.dart';

class SearchController extends GetxController {
  bool isDataReceived = false;
  String? recipeName;
  double? calories;
  double? fats;
  double? proteins;
  double? carbs;

  Future uploadImage(File imageFile) async {
    var stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();
    var uri = Uri.parse(
        "https://api.spoonacular.com/food/images/analyze?apiKey=eb1dcac904fd4b75aab240404419274e");
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      var responseBody = await http.Response.fromStream(response);
      var rB = jsonDecode(responseBody.body);
      var searchMain = Search.fromJson(rB);
      recipeName = searchMain.category.name;
      calories = searchMain.nutrition.calories.value * 0.13;
      proteins = searchMain.nutrition.protein.value;
      carbs = searchMain.nutrition.carbs.value;
      fats = searchMain.nutrition.fat.value;
      print(searchMain.nutrition.calories.value);
      print(searchMain.category.name);
    } else {
      print(response.statusCode);
    }
  }


}

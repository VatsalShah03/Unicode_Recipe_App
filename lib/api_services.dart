import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models.dart';

class ApiServices {

  String? title;
  String? imgUrl;
  bool? isVeg;
  RecipesMain? recipesMain;
  List<Recipes>? _recipesList;

  getData() async {
    var responseBody;
    String apiKey = "1b0f01b8eb9946beb0055f64095a985e";
    String baseUrl = "https://api.spoonacular.com/recipes";
    String url = "$baseUrl/random?number=5&apiKey=$apiKey&number=100";
    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        //log(responseBody.toString());
        title = responseBody['recipes'][0]['title'];
        imgUrl = responseBody['recipes'][0]['image'];
        isVeg = responseBody['recipes'][0]['vegetarian'];
        // debugPrint(title);
        // debugPrint(imgUrl);
        // debugPrint(isVeg.toString());
        var recipesMain = RecipesMain.fromJson(responseBody);
        _recipesList = recipesMain.recipes;
      } else {
        print(response.statusCode);
      }
      return _recipesList;
    } catch (e) {
      print(e);
    }
  }

}
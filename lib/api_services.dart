import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

class ApiServices extends GetxController{

  String? title;
  String? imgUrl;
  bool? isVeg;
  RecipesMain? recipesMain;
  List<Recipes>? recipesList;

  getData(String? query) async {
    var responseBody;
    String apiKey = "1b0f01b8eb9946beb0055f64095a985e";
    String baseUrl = "https://api.spoonacular.com/recipes";
    String url = "$baseUrl/random?number=5&apiKey=$apiKey";
    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        //log(responseBody.toString());
        // title = responseBody['recipes'][0]['title'];
        // imgUrl = responseBody['recipes'][0]['image'];
        // isVeg = responseBody['recipes'][0]['vegetarian'];
        // debugPrint(title);
        // debugPrint(imgUrl);
        // debugPrint(isVeg.toString());
        var recipesMain = RecipesMain.fromJson(responseBody);
        recipesList = recipesMain.recipes.obs;
      } else {
        print(response.statusCode);
      }
      if(query!= null){
        List<Recipes> recipes = [];
        recipes.addAll(recipesList!);
          recipes.retainWhere((recipe) {
            String term = query.toLowerCase();
            String recipeName = recipe.title!;
            return recipeName.contains(term);
          });
        recipesList = recipes;
      }
      return recipesList;

    } catch (e) {
      print(e);
    }
  }

}
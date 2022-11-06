import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices{
  
   getData() async {
    String url="https://api.spoonacular.com/recipes/random?number=1&tags=vegetarian,dessert";
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200 ){
      var responseBody = jsonDecode(response.body);
      print(responseBody);
    }
  }

}
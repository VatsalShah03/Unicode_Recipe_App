import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unicode_lp/Screens/HomePage/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class HomeController extends GetxController{
  final uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController recipeController = TextEditingController();
  RecipesMain? recipesMain;
  var recipes = <Recipes>[].obs;
  var isLiked = false.obs;
  var wishList = <WishList>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchRecipes();
    fetchWishList();
  }

  fetchRecipes() async {
    var responseBody;
    String apiKey = "d8c5f57273584c9198aa22b0462a8f38";
    String baseUrl = "https://api.spoonacular.com/recipes";
    String url = "$baseUrl/random?number=5&apiKey=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);

        var recipesMain = RecipesMain.fromJson(responseBody);
        recipes = recipesMain.recipes.obs;
      } else {
        print(response.statusCode);
      }
      return recipes;
    } catch (e) {
      print(e);
    }
  }

  searchRecipes() {
    recipes.retainWhere((element) {
      String term = recipeController.text.toLowerCase();
      String recipeName = element.title!.toLowerCase();
      return recipeName.contains(term);
    });
    print(recipes.toString());
  }

  addToWishlist({required Recipes recipe}) async {
    await FirebaseFirestore.instance.collection('Users').doc(uid).collection("Favourites").doc(recipe.id.toString()).set(
      {
        "Title": recipe.title,
        "ImageUrl": recipe.image,
        "Id": recipe.id,
        "Summary": recipe.summary,
        "Instructions": recipe.instructions,
        "isVeg": recipe.vegetarian,
        "Docid": recipe.id,
      }
    );
  }

  deleteFromWishlist({required String docid})async{
    await FirebaseFirestore.instance.collection("Users").doc(uid).collection("Favourites").doc(docid).delete();
  }

  Stream<List<WishList>> fetchWishList() {
    return FirebaseFirestore.instance.collection("Users").doc(uid).collection("Favourites").snapshots().map(
            (snapshot) =>
            snapshot.docs.map((doc) => WishList.fromJson(doc.data())).toList());
  }

}
class WishList {
  String id;
  final String Summary;
  final String image;
  final String title;
  final bool isVeg;
  final String docid;

  WishList(
      {this.id = '',
        required this.Summary,
        required this.image,
        required this.isVeg,
        required this.title,
        required this.docid,});

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Summary': Summary,
    'isVeg': isVeg,
    'Title': title,
    'ImageUrl': image,
    'Docid': docid,
  };

  static WishList fromJson(Map<String, dynamic> json) => WishList(
    Summary: json["Summary"],
    isVeg: json["isVeg"],
    title: json["Title"],
    image: json["ImageUrl"],
    docid: json["Docid"].toString(),
    id: json['Id'].toString(),
  );
}


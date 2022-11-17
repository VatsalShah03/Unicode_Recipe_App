import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:like_button/like_button.dart';
import 'package:unicode_lp/Screens/profile_page.dart';
import 'package:unicode_lp/Screens/recipe_details.dart';
import 'package:unicode_lp/State%20Mgmt/home_controller.dart';
import 'package:unicode_lp/api_services.dart';
import 'package:unicode_lp/models.dart';
import 'package:unicode_lp/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(HomeController());
  TextEditingController recipeController = TextEditingController();
  // getRecipeData(String? query) async {
  //   _recipesList = await ApiServices().getData(query ?? "");
  //   _recipesList2 = _recipesList.obs;
  //   //print(_recipesSearched);
  //   print(_recipesList!.length);
  // }

  @override
  void initState() {
    // TODO: implement initState
    homeController.fetchRecipes();
    //_recipeController.addListener(() {searchRecipes(); });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      body: SafeArea(
        child: FutureBuilder(
          future: homeController.fetchRecipes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Recipes",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                    ),
                  ),
                  NeuBox(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: homeController.recipeController,
                      decoration: InputDecoration(
                        suffixIconColor: Colors.black,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            homeController.searchRecipes();
                          },
                        ),
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                    ),
                  ),
                  GetX<HomeController>(
                    builder: (homeController) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: homeController.recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          Recipes recipe = homeController.recipes[index];
                          print(recipe.title);
                          return RecipeWidget(
                            recipe: recipe,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class RecipeWidget extends StatefulWidget {
  final Recipes recipe;

  RecipeWidget({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  HomeController homeController = Get.put(HomeController());
  Future<bool> onLikeTapped(isLiked) async {
    await homeController.addToWishlist(recipe: widget.recipe);
    return !isLiked;
  }
  var isLiked = false.obs;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetails(
                      id: widget.recipe.id.toString(),
                      imgUrl: widget.recipe.image,
                      title: widget.recipe.title,
                      summary: widget.recipe.summary,
                      instructions: widget.recipe.instructions,
                  recipeee: widget.recipe,
                    )));
      },
      child: NeuBox(
        margin: EdgeInsets.all(15),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.recipe.image!,
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.title!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.recipe.vegetarian
                        ? Text("Vegetarian",
                            style: TextStyle(color: Colors.green))
                        : Text("Non-Vegetarian",
                            style: TextStyle(color: Colors.red)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LikeButton(
                        onTap: onLikeTapped,
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

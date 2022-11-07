import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:unicode_lp/api_services.dart';
import 'package:unicode_lp/models.dart';
import 'package:unicode_lp/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';






class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Recipes>? _recipesList;

  getRecipeData() async {
    _recipesList = await ApiServices().getData();
    print(_recipesList!.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    getRecipeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      body: SafeArea(
        child: FutureBuilder(
          future: getRecipeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Recipes",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _recipesList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Recipes recipe = _recipesList![index];
                      return RecipeWidget(
                        title: recipe.title!,
                        imgUrl: recipe.image!,
                        isVeg: recipe.vegetarian,
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class RecipeWidget extends StatelessWidget {
  final String title;
  final String imgUrl;
  final bool isVeg;
  const RecipeWidget(
      {Key? key,
      required this.title,
      required this.imgUrl,
      required this.isVeg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeuBox(
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imgUrl,
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
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                  ),
                  isVeg
                      ? Text(
                      "Vegetarian", style: TextStyle(color: Colors.green))
                      : Text(
                      "Non-Vegetarian",
                      style: TextStyle(color: Colors.red))
                ],
              ))
        ],
      ),
    );
  }
}

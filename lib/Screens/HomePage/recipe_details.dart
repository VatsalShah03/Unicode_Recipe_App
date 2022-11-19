import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:unicode_lp/Screens/HomePage/home_controller.dart';
import 'package:unicode_lp/constants.dart';
import 'package:html/parser.dart';

import 'models.dart';

class RecipeDetails extends StatefulWidget {
  final Recipes? recipeee;
  final String? id;
  final String? imgUrl;
  final String? title;
  final String? instructions;
  final String? summary;
  const RecipeDetails(
      {Key? key,
      required this.id,
      required this.imgUrl,
      required this.title,
      required this.instructions,
      required this.summary,
      required this.recipeee})
      : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  HomeController homeController = Get.put(HomeController());
  Future<bool> onLikeTapped(isLiked) async {
    await homeController.addToWishlist(recipe: widget.recipeee!);
    return !isLiked;
  }
  var isLiked = false.obs;

  @override
  Widget build(BuildContext context) {
    final document = parse(widget.summary);
    String summary = parse(document.body!.text).documentElement!.text;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Image.network(
                    widget.imgUrl!,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.fill,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: NeuBox(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(left: 15, top: 15),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          homeController.addToWishlist(recipe: widget.recipeee!);
                        },
                        child: NeuBox(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(right: 15, top: 15),
                            child: LikeButton(
                              onTap: onLikeTapped,
                            ),),
                      ),
                    ],
                  ),
                ]),
                SizedBox(
                  width: double.infinity,
                  child: NeuBox(
                    padding: const EdgeInsets.all(15.0),
                    margin: EdgeInsets.all(15),
                    child: Text(
                      widget.title!,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Summary: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          summary,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              wordSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

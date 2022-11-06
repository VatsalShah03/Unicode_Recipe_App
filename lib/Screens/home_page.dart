import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:unicode_lp/api_services.dart';
import 'package:unicode_lp/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? title;
  String? imgUrl;
  bool? isVeg;

  ApiServices apiServices = ApiServices();
  getData() async {
    var responseBody;
    String apiKey = "1b0f01b8eb9946beb0055f64095a985e";
    String baseUrl = "https://api.spoonacular.com/recipes";
    String url = "$baseUrl/random?number=5&apiKey=$apiKey&number=1";
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        //log(responseBody.toString());
        title = responseBody['recipes'][0]['title'];
        imgUrl = responseBody['recipes'][0]['image'];
        isVeg = responseBody['recipes'][0]['vegetarian'];
        debugPrint(title);
        debugPrint(imgUrl);
        debugPrint(isVeg.toString());
      } else {
        print(response.statusCode);
      }
      return responseBody;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      body: SafeArea(
        child: FutureBuilder(
          future: getData(),
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
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return RecipeWidget(
                        title: title!,
                        imgUrl: imgUrl!,
                        isVeg: isVeg!,
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

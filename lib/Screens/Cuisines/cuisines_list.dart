import 'package:flutter/material.dart';
import 'package:unicode_lp/Screens/Cuisines/cuisines_controller.dart';
import 'package:get/get.dart';
import 'package:unicode_lp/Screens/Cuisines/cuisines_model.dart';
import '../../constants.dart';

class CuisinesList extends StatefulWidget {
  final String cuisine;
  const CuisinesList({Key? key, required this.cuisine}) : super(key: key);

  @override
  State<CuisinesList> createState() => _CuisinesListState();
}

class _CuisinesListState extends State<CuisinesList> {
  CuisinesController cuisinesController = Get.put(CuisinesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();},
                    child: const NeuBox(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 15),
                      child: Icon(Icons.arrow_back),
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.cuisine,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Results>>(
                future:
                    cuisinesController.getCuisinesData(cuisine: widget.cuisine),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                    Results results = cuisinesController.results[index];
                    print(results.title);
                    return CuisinesListWidget(
                        title: results.title, imgUrl: results.image);
                  }));
                }),
          ],
        ),
      ),
    );
  }
}

class CuisinesListWidget extends StatelessWidget {
  final String title;
  final String imgUrl;
  const CuisinesListWidget(
      {Key? key, required this.title, required this.imgUrl})
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
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

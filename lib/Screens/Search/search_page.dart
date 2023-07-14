import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicode_lp/Screens/Search/search_controller.dart' as c;
import 'dart:io';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:fl_chart/fl_chart.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  c.SearchController searchController = Get.put(c.SearchController());
  File? image;
  bool isDataReceived = false;

  Future clickImage({required ImageSource imageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final imgTemp = File(image.path);
      setState(() {
        this.image = imgTemp;
      });
    } on PlatformException catch (e) {
      print("Failed to click image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Search",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: NeuBox(
                margin: EdgeInsets.all(30),
                child: image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            NeuBox(
                                child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () =>
                                  clickImage(imageSource: ImageSource.camera),
                            )),
                            NeuBox(
                                child: IconButton(
                              icon: Icon(Icons.photo_library_outlined),
                              onPressed: () =>
                                  clickImage(imageSource: ImageSource.gallery),
                            )),
                          ],
                        ),
                      )),
          ),
          isDataReceived == false
              ? Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: CircularProgressIndicator(),
                              ));
                      searchController.uploadImage(image!).whenComplete(() {
                        Navigator.pop(context);
                        setState(() {
                          isDataReceived = true;
                        });
                      });
                    },
                    child: NeuBox(
                        color: Colors.orange,
                        padding: EdgeInsets.all(15),
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              : Column(
                  children: [
                    Center(
                        child: Text(
                      searchController.recipeName!,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: NeuBox(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.all(30),
                          child: BarChart(BarChartData(
                              titlesData: FlTitlesData(
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 10,
                                          getTitlesWidget: (value, titlesMeta) {
                                            return Text(value.toString());
                                          }),
                                      axisNameWidget: Text("in g")),
                                  bottomTitles: AxisTitles(
                                      axisNameWidget: Text("Nutrition"),
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, titlesMeta) {
                                            String title;
                                            switch (value.toInt()) {
                                              case 2:
                                                title = "Calories";
                                                break;
                                              case 4:
                                                title = "Proteins";
                                                break;
                                              case 6:
                                                title = "Carbs";
                                                break;
                                              case 8:
                                                title = "Fats";
                                                break;
                                              default:
                                                title = 'A';
                                            }
                                            return Text(title);
                                          }))),
                              barGroups: [
                                BarChartGroupData(x: 2, barRods: [
                                  BarChartRodData(
                                      toY: searchController.calories ?? 0)
                                ]),
                                BarChartGroupData(x: 4, barRods: [
                                  BarChartRodData(
                                      toY: searchController.proteins ?? 0)
                                ]),
                                BarChartGroupData(x: 6, barRods: [
                                  BarChartRodData(
                                      toY: searchController.carbs ?? 0)
                                ]),
                                BarChartGroupData(x: 8, barRods: [
                                  BarChartRodData(
                                      toY: searchController.fats ?? 0)
                                ]),
                              ]))),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

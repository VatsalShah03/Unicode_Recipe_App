import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicode_lp/constants.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  File? image;
  var ref;
  var userCollection = FirebaseFirestore.instance.collection("Users");
  TextEditingController titleController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  bool isVeg = true;

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

  Future uploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    ref = FirebaseStorage.instance
        .ref()
        .child('${user.email!}/${basename(image!.path)}');
    if (image != null) {
      await ref.putFile(File(image!.path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) async {
          final docRef = await userCollection.doc(uid).collection("My Recipes").doc();
          await docRef.set({"ImageUrl": value,
            "Title": titleController.text.trim(),
            "Ingredients": ingredientsController.text.trim(),
            "Summary": summaryController.text.trim(),
            "isVeg": isVeg,
          "Id": docRef.id});
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    ingredientsController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NeuBox(
                margin: EdgeInsets.all(15),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Add Recipes",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: NeuBox(
                        margin: EdgeInsets.all(30),
                        child: image != null
                            ? Image.file(image!)
                            : Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    NeuBox(
                                        child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      onPressed: () => clickImage(
                                          imageSource: ImageSource.camera),
                                    )),
                                    NeuBox(
                                        child: IconButton(
                                      icon: Icon(Icons.photo_library_outlined),
                                      onPressed: () => clickImage(
                                          imageSource: ImageSource.gallery),
                                    )),
                                  ],
                                ),
                              )),
                  ),
                  NeuBox(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TextFormField(
                        controller: titleController,
                        style: TextStyle(fontSize: 28),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Enter Title"),
                      )),
                  NeuBox(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TextFormField(
                        maxLines: 10,
                        style: TextStyle(fontSize: 20),
                        controller: ingredientsController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Ingredients"),
                      )),
                  NeuBox(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TextFormField(
                        controller: summaryController,
                        maxLines: 10,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Summary"),
                      )),
                  NeuBox(
                    margin: EdgeInsets.only(left: 30,right: 30,top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Vegetarian : "),
                      Checkbox(
                          value: isVeg,
                          onChanged: (bool? value) {
                            setState(() {
                              isVeg = value!;
                            });
                          })
                    ],
                  )),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Center(
                                  child: CircularProgressIndicator(),
                                ));
                        uploadImage().whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      },
                      child: NeuBox(
                          color: Colors.orange,
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Text(
                            "Upload",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:unicode_lp/Screens/HomePage/home_controller.dart';
import '';
import '../constants.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  HomeController homeController = Get.put(HomeController());

  Stream<List<WishList>> fetchWishList() => FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Favourites")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => WishList.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Favourites",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
              ),
            ),
            StreamBuilder<List<WishList>>(
                stream: fetchWishList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          WishList wishList = snapshot.data![index];
                          print(snapshot.data!.length);
                          return buildFav(wishList: wishList, docid: wishList.id);
                          //   FavWidget(
                          //   title: wishList.title,
                          //   imgUrl: wishList.image,
                          //   isVeg: wishList.isVeg,
                          //   id: wishList.id,
                          // );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: Text("Hey"),
                    );
                  }
                })
          ],
        ),
      )),
    );
  }
}

Widget buildFav({required WishList wishList, required String docid}) {
  return FavWidget(
      title: wishList.title,
      imgUrl: wishList.image,
      isVeg: wishList.isVeg,
      id: wishList.id, docid: docid,);
}

class FavWidget extends StatefulWidget {
  final String docid;
  final String id;
  final String title;
  final String imgUrl;
  final bool isVeg;
  FavWidget(
      {Key? key,
      required this.title,
      required this.imgUrl,
      required this.isVeg,
      required this.id, required this.docid})
      : super(key: key);

  @override
  State<FavWidget> createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  HomeController homeController = Get.put(HomeController());

  Future<bool> onDeleteTapped(isLiked) async {
    setState(() {
      homeController.deleteFromWishlist(docid: widget.docid);
    });
    return !isLiked;
  }

  bool isLiked = true;
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
                  widget.imgUrl,
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
                widget.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isVeg
                      ? Text("Vegetarian",
                          style: TextStyle(color: Colors.green))
                      : Text("Non-Vegetarian",
                          style: TextStyle(color: Colors.red)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LikeButton(
                      onTap: onDeleteTapped,
                      likeBuilder: (isLiked) {
                        return Icon(
                          Icons.delete,
                          color: Colors.red,
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

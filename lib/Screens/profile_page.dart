import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:unicode_lp/constants.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({Key? key})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('Users');
  String? fName;
  String? lName;


  Future<List<String?>> GetUserDetails() async {
    DocumentSnapshot ds = await userCollection.doc(user.uid).get();
    fName = ds.get("First Name");
    lName = ds.get("Last Name");
    print(fName);
    return [fName, lName];
  }

  @override
  void initState() {
    // TODO: implement initState
    GetUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: GetUserDetails(),
        builder:(context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return Center(
          child: Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.5,
            child: Stack(children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 6,
                      child: NeuBox(child: Container(),),
                      ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 110,
                      ),
                      CircleAvatar(
                        backgroundImage: user.photoURL == null
                            ? AssetImage("Assets/person.png") as ImageProvider
                            : NetworkImage(user.photoURL!),
                        radius: 100,
                      )
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      user.displayName == null ? "${fName!} ${lName!}" : user.displayName!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      user.email == null ? "Email" : user.email!,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
  }
      ),
    );
  }
}

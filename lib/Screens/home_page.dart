import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicode_lp/Screens/profile_page.dart';
import 'package:unicode_lp/constants.dart';

import '../State Mgmt/g_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: MyDrawer(),
      extendBody: true,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: ()=> Scaffold.of(context).openDrawer(),
                      child: NeuBox(
                    child: Icon(Icons.menu),
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(left: 15, top: 15),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(alignment: Alignment.center, children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    CircleAvatar(
                      backgroundImage: user?.photoURL == null
                          ? AssetImage("Assets/person.png") as ImageProvider
                          : NetworkImage(user!.photoURL!),
                      radius: 25,
                    )
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width*0.6,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(trailing: Icon(Icons.chevron_right),

              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
            },title: Text("My Profile"),),
            GestureDetector(
                onTap: () {
                  final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                child: NeuBox(child: Text("Sign Out"), margin: EdgeInsets.only(bottom: 15),padding: EdgeInsets.all(10),))
          ],
        ),
      ),
    );
  }
}


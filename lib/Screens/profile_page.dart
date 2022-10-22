import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:unicode_lp/Screens/login_page.dart';
import 'package:unicode_lp/constants.dart';

class ProfilePage extends StatelessWidget {
  final String Name;
  final String email;
  const ProfilePage({Key? key, required this.Name, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          NeuBox(child: Center(child: Text("Sign Out")),padding: EdgeInsets.all(10),margin: EdgeInsets.only(right: 10,top: 10, bottom: 5),)
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: screenWidth*0.8,
          height: screenHeight*0.5,
          child: Stack(
            children: [Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                  ),
                ),
                Expanded(flex: 6,child: Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                      depth: 4,
                      lightSource: LightSource.topLeft,
                      color: Colors.white),
                  child: Container(),
                ))
              ],
            ),
              Center(
                child: Column(
                  children: [
                    Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(backgroundColor: Colors.white,radius: 110,),
                          CircleAvatar(backgroundImage: AssetImage("Assets/person.png"),radius: 100,)]),
                    SizedBox(height: 30,),
                    Text(Name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                    Text(email, style: TextStyle( fontSize: 20),),
                  ],
                ),
              ),]
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "Assets/login-bg.jpg",
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.fill,
          ),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration:
                BoxDecoration(color: Colors.grey.shade400.withOpacity(0.1)),
              )),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Neumorphic(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.all(20),
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 8,
                      lightSource: LightSource.topLeft,
                      color: Colors.grey),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          "Register! ",
                          style: TextStyle(
                              fontSize: screenWidth*0.15,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth*0.3,
                            child: NeuBox(child: TextField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none),
                            ),
                              padding: EdgeInsets.only(left: 15),),
                          ),

                          SizedBox(
                            width: screenWidth*0.3,
                            child: NeuBox(child: TextField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  hintText: "Surname",
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none),
                            ),
                              padding: EdgeInsets.only(left: 15),),
                          ),
                        ],
                      ),
                      NeuBox(child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none),
                      ),margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.only(left: 15),),
                      NeuBox(
                        child: TextField(
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                        ),
                        margin:
                        EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.only(left: 15),
                      ),
                      NeuBox(
                        child: TextField(
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                        ),
                        margin:
                        EdgeInsets.only(bottom: 20

                        ),
                        padding: EdgeInsets.only(left: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                        child: Container(
                          width: double.infinity,
                          child: NeuBox(
                            child: Center(child: Text("Sign In",style: TextStyle(color: Colors.white),)),
                            padding: EdgeInsets.all(10),
                            color: Colors.grey[700],
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

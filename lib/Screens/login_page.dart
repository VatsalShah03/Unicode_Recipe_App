import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:unicode_lp/Screens/register_page.dart';
import 'package:unicode_lp/State%20Mgmt/g_sign_in.dart';
import 'package:unicode_lp/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isValidEmail(String input) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Future signIn() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Center(child: CircularProgressIndicator());
            });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim());
        Navigator.of(context).pop();
      } catch (e) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) {
              return Center(child: Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(e.toString()),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("OK", style: TextStyle(color: Colors.white),))
                    ],
                  )));
            });
      }
    }

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
                child: Form(
                  key: _formKeyLogin,
                  child: Neumorphic(
                    margin: EdgeInsets.symmetric(horizontal: 30),
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
                          padding: const EdgeInsets.only(top: 30, left: 15),
                          child: Text(
                            "Hello,",
                            style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Login Now!",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        NeuBox(child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.black),
                          validator: (text) => isValidEmail(text!) ? null : "Enter valid email",
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                        ),margin: EdgeInsets.all(20),
                          padding: EdgeInsets.only(left: 15),),
                        NeuBox(
                          child: TextFormField(
                            controller: _passController,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            validator:   (text) {
                              if (text == null || text.isEmpty) {
                                return 'Password cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none),
                          ),
                          margin:
                              EdgeInsets.only(bottom: 20, left: 20, right: 20),
                          padding: EdgeInsets.only(left: 15),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                            child: InkWell(
                              onTap: (){
                                if(_formKeyLogin.currentState!.validate()){
                                  signIn();
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: NeuBox(
                                  child: Center(child: Text("Sign In",style: TextStyle(color: Colors.white),)),
                                  padding: EdgeInsets.all(10),
                                  color: Colors.grey[700],
                                ),
                              ),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Row(
                            children: [
                              Text(
                                "Don't have an account?  ",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));},
                                child: Text(
                                  "Register Now",
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Text("---OR---"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: (){
                                final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                                provider.GoogleLogin();

                              },
                              child: NeuBox(
                                child: Center(
                                  child: Image.asset(
                                    "Assets/images.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                padding: EdgeInsets.all(10),
                              ),
                            ),
                            NeuBox(
                              child: Center(
                                child: Image.asset(
                                  "Assets/f-logo.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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

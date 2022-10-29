import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicode_lp/Screens/main_page.dart';
import 'package:unicode_lp/Screens/login_page.dart';
import 'package:unicode_lp/State%20Mgmt/g_sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,


        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily
        ),
        home: HomePage(),
      ),
    );
  }
}

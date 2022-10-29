import 'package:flutter/material.dart';
class CuisinesPage extends StatefulWidget {
  const CuisinesPage({Key? key}) : super(key: key);

  @override
  State<CuisinesPage> createState() => _CuisinesPageState();
}

class _CuisinesPageState extends State<CuisinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:SafeArea(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Cuisines", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),),
          ),
        ],
      )),
    );
  }
}

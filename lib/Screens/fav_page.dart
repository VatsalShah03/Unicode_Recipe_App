import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Favourites", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),),
          ),
        ],
      )),
    );
  }
}

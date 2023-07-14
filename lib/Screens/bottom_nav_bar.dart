import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:unicode_lp/Screens/Cuisines/cuisines_page.dart';
import 'package:unicode_lp/Screens/My%20Recipes/my_recipes.dart';
import 'package:unicode_lp/Screens/Search/search_page.dart';
import 'package:unicode_lp/Screens/fav_page.dart';
import 'package:unicode_lp/Screens/HomePage/home_page.dart';
import 'package:unicode_lp/Screens/Profile%20Page/profile_page.dart';
import '../State Mgmt/g_sign_in.dart';
import '../constants.dart';
import 'Add Recipes/add_recipes.dart';

class NeumorphicBottomNavigation extends StatefulWidget {
  @override
  _NeumorphicBottomNavigationState createState() =>
      _NeumorphicBottomNavigationState();
}

class _NeumorphicBottomNavigationState
    extends State<NeumorphicBottomNavigation> {
  int selectedIndex = 0;

  List<Widget> _navigationScreens = [
    HomePage(),
    FavPage(),
    SearchPage(),
    CuisinesPage(),
    MyRecipes(),
  ];

  List<NavigationItem> items = [
    NavigationItem(
      icon: Icon(Icons.home),
    ),
    NavigationItem(
      icon: Icon(Icons.favorite),
    ),
    NavigationItem(
      icon: Icon(Icons.search)
    ),
    NavigationItem(
      icon: Icon(Icons.fastfood),
    ),
    NavigationItem(icon: Icon(Icons.list))
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: isSelected
            ? []
            : [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5.0, -5.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
              ],
        gradient: isSelected
            ? LinearGradient(colors: [
                // Color(0xFF9E9E9E),
                Color(0xFFBDBDBD),
                Color(0xFFE0E0E0),
                Color(0xFFEEEEEE),
                Color(0xFFF5F5F5),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)
            : null,
      ),
      child: IconTheme(
        data: IconThemeData(
          size: 25.0,
          color: isSelected ? Colors.orange : Colors.grey[800],
        ),
        child: item.icon as Widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: SafeArea(child: MyDrawer()),
      body: SafeArea(
        child: Column(
          children: [
            //App Bar
            Container(
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: const NeuBox(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(left: 15),
                          child: Icon(Icons.menu),
                        )),
                  ),
                  NeuBox(
                      margin: EdgeInsets.all(15),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddRecipe()));
                        },
                      ))
                ],
              ),
            ),

            Expanded(child: _navigationScreens.elementAt(selectedIndex)),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 75.0,
        //margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            var itemIndex = items.indexOf(item);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = itemIndex;
                });
              },
              child: _buildItem(item, selectedIndex == itemIndex),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NavigationItem {
  final Icon? icon;

  NavigationItem({this.icon});
}

class MyDrawer extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 10,),
          CircleAvatar(
            backgroundImage: user.photoURL == null
                ? AssetImage("Assets/person.png") as ImageProvider
                : NetworkImage(user.photoURL!),
            radius: 100,
          ),
          ListTile(
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            title: Text(
              "My Profile",
              style: TextStyle(fontSize: 25),
            ),
          ),
          GestureDetector(
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              child: NeuBox(
                child: Text("Sign Out"),
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.all(10),
              ))
        ],
      ),
    );
  }
}

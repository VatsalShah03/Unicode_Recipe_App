import 'package:flutter/material.dart';
import 'package:unicode_lp/Screens/cuisines_page.dart';
import 'package:unicode_lp/Screens/fav_page.dart';
import 'package:unicode_lp/Screens/home_page.dart';

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
    CuisinesPage(),
  ];

  List<NavigationItem> items = [
    NavigationItem(
      icon: Icon(Icons.home),
    ),
    NavigationItem(
      icon: Icon(Icons.favorite),
    ),
    NavigationItem(
      icon: Icon(Icons.fastfood),
    ),
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
          color: isSelected ? Colors.red[600] : Colors.grey[800],
        ),
        child: item.icon as Widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _navigationScreens.elementAt(selectedIndex),
      extendBody: true,
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 75.0,
        //margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.white),
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

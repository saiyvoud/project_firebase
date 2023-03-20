import 'package:e_commerces/components/color.dart';
import 'package:e_commerces/page/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  final _children = [
    HomePage(),
    Container(height: 120,decoration: BoxDecoration(color: primaryColor),),
  ];
  int _currentIndex = 0;

  void _onTapItem(index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: primaryColor,
        unselectedItemColor: primaryColorGrey,
        onTap: _onTapItem,
        currentIndex: _currentIndex,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,size: 25,),label: 'Home' ),
        BottomNavigationBarItem(icon: Icon(Icons.home,size: 25,),label: 'My order' )
      ]),
    );
  }
}
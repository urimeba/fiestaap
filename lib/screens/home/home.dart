
import 'package:fiestapp/screens/home/promo_list.dart';
import 'package:fiestapp/screens/home/prueba2.dart';
import 'package:fiestapp/screens/navigation/profile.dart';
import 'package:flutter/material.dart';
import 'package:fiestapp/screens/home/promos.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget(Colors.black),
  //  PromoList(),
   Promociones(),
   Profile(),
  ];

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Fiestaap'),
     ),
     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped,
       currentIndex: _currentIndex,
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.cake),
           title: new Text('Eventos'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.local_atm),
           title: new Text('Promos'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Perfil')
         )
       ],
     ),
   );
  }
}
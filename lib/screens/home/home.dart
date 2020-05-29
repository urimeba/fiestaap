
import 'package:fiestapp/screens/home/promo_new.dart';
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


    void _showSettingsPanel(){
           showModalBottomSheet(
             context: context, 
             builder: (context) {
               return Container(
                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                 child: NewPromo(),
               );
             }
             );
        }

    return Scaffold(
     appBar: AppBar(
       title: Text('Fiestaap'),
       elevation: 0,
       actions: <Widget>[
         FlatButton.icon(
           onPressed: () => _showSettingsPanel(), 
           icon: Icon(Icons.person), 
           label: Text('Nueva promo')
           ),
       ],
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
import 'package:fiestapp/screens/home/promo_new.dart';
import 'package:fiestapp/screens/navigation/profile.dart';
import 'package:flutter/material.dart';
import 'package:fiestapp/screens/home/promos.dart';
import 'events.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Eventos(),
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
    void _showNewPromo(){
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: NewPromo(),
          );
        }
      );
    }
    
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Theme.of(context).primaryColor,
       title: Text(
         'Fiestaap',
         style: TextStyle(
           fontSize: 20,
           color: Colors.white
         ),
       ),
       elevation: 0,
       actions: <Widget>[
         FlatButton.icon(
           onPressed: () => _showNewPromo(), 
           icon: Icon(
             Icons.add_circle,
             color: Colors.white,
           ),
           label: Text(
             'Promo',
             style: TextStyle(
               fontSize: 16,
               color: Colors.white
             ),
           )
         ),
       ],
     ),
     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       backgroundColor: Colors.white,
       fixedColor: Theme.of(context).primaryColor,
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
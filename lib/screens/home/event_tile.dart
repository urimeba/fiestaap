import 'package:fiestapp/models/event.dart';
import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';

// class EventTile extends StatelessWidget {
//   final Event event;

//   EventTile({ this.event });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 8.0),
//       child: Card(
//         margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
//         child: ListTile(
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage('https://comps.canstockphoto.com/bottles-of-alcohol-with-tropical-clipart-vector_csp18200753.jpg'),
//             backgroundColor: Colors.transparent,
//           ),
//           title: Text('Dueno: ${event.dueno}'),
//           subtitle: Text(
//             'Nombre: ${event.nombre}\nCodigo: ${event.codigo}\nMonto total: \$${event.monto}.00 MXN'
//             ),
//           isThreeLine:  true,
//         ),
//         ),
//       );
//   }
// }





class EventTile extends StatelessWidget {
  final Event event;
  final AuthService _auth = AuthService();
  String _dueno = '';

  EventTile({ this.event });

  @override
  Widget build(BuildContext context) {

    Future<String> _getDueno() async{
      var actualUser = await _auth.getUidUser();
      if(actualUser.uid==event.uid){
        return 'Tú';
      }else{
        return event.dueno;
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: FutureBuilder(
        future: _getDueno(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            return getEvent(snapshot, event);
          }else{
            return CircularProgressIndicator();
          }
          })
      );
  }
}


Widget getEvent(snapshot, event){
      return Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://comps.canstockphoto.com/bottles-of-alcohol-with-tropical-clipart-vector_csp18200753.jpg'),
              backgroundColor: Colors.transparent,
            ),
          ),
          title: Text('Dueño: ' + snapshot.data),
          subtitle: Text(
            'Nombre: ${event.nombre}\nCodigo: ${event.codigo}\nMonto total: \$${event.monto}.00 MXN'
            ),
          isThreeLine:  true,
        ),
        );
    }
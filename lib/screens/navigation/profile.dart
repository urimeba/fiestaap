import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  final AuthService _auth = AuthService();
  String name = "";
  String email = "";

  Future<List> _getData() async{
    return await _auth.getDataUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            return getProfile(context, snapshot, _auth);
          }else{
            return CircularProgressIndicator();
          }
      })
    );
  }
}

Widget getProfile(context, snapshot, _auth){
  return Center(
    child: Container(
      padding: EdgeInsets.all(30),
      child: Column(
          children: <Widget>[
            Text(
              "Perfil",
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).primaryColor
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre',
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).hintColor
              ),
            ),
            SizedBox(height: 20),
            Text(
              snapshot.data[0],
              style: TextStyle(
                  fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Email',
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).hintColor
              ),
            ),
            SizedBox(height: 20),
            Text(
              snapshot.data[1],
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 60),
            FlatButton.icon(
                onPressed: () async{
                  // getData();
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.redAccent,
                ),
                label: Text(
                  'Cerrar sesion',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                )
            ),
          ]
      )
    )
  );
}
// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {

//   final AuthService _auth = AuthService();
//   String name = "";
//   String email = "";

//   getData() async{
//     List<String> data = await _auth.getDataUser();
//     print(data[0]);
//     print(data[1]);
//     setState(() {
//       name = data[0];
//       email = data[1];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Text("Perfil"),
//           SizedBox(height: 20),
//           Text(name),
//           SizedBox(height: 20),
//           Text("Nombre"),
//           SizedBox(height: 20),
//           Text(email),
//           SizedBox(height: 20),
          

//           FlatButton.icon(
//             onPressed: () async{
//               // getData();
//               await _auth.signOut();
//             }, 
//             icon: Icon(Icons.person), 
//             label: Text('Cerrar sesion')
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:fiestapp/models/event.dart';
import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fiestapp/shared/constants.dart';

import 'package:fiestapp/services/database.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventTile extends StatelessWidget {
  final Event event;
  final AuthService _auth = AuthService();
  var actualUser;
  

  EventTile({ this.event });

  @override
  Widget build(BuildContext context) {

    Future<String> _getDueno() async{
      actualUser = await _auth.getUidUser();
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
            return getEvent(snapshot, event, actualUser);
          }else{
            return CircularProgressIndicator();
          }
          })
      );
  }
}

Widget getEvent(snapshot, event, actualUser){

  String uid = actualUser.uid;
  int montoActual = event.colabs[uid]['monto'];

      return Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ExpansionTile(
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

            children: <Widget>[
                // Text(
                //   "Tu aportación actual: $montoActual",
                //   style: TextStyle(fontSize: 18),
                // ),
                PForm(monto: montoActual, codigo:event.codigo)
              ],
            ),
        );
    }


class PForm extends StatefulWidget {
  final int monto;
  final int codigo;

  const PForm ({ Key key, this.monto, this.codigo }): super(key: key);

  @override
  _PFormState createState() => _PFormState();
}

class _PFormState extends State<PForm> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService databaseService = DatabaseService();
  final AuthService _auth = AuthService();
  int _monto;
  int _codigo;
  String _error = '';
  

  @override
  Widget build(BuildContext context) {

    int m = widget.monto;
    _codigo = widget.codigo;
    

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Actualiza tu aportación actual',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: m.toString(),
            decoration: textInputDecoration.copyWith(hintText: 'Aportación actual'),
            validator: (val) => val.length < 1 ? 'El monto no puede ser nulo' : null,
            onChanged: (val) => setState(() => _monto = num.tryParse(val))
          ),
          Text(
              _error,
              style: TextStyle(
                color: Colors.red, 
                fontSize: 14.0
              ),
          ),
          RaisedButton(
            color: Colors.pink[400],
            child: Text('Actualizar', style: TextStyle(color: Colors.white),),
            onPressed: () async{
              if(_formKey.currentState.validate()){
                print(_monto);
                print(_codigo);

                final CollectionReference eventsCollection = Firestore.instance.collection('eventos');
                var event;

                try{
                  event =  eventsCollection
                  .document('$_codigo');

                  final actualUser = await _auth.getUidUser();
                  final uid = actualUser.uid;

                  Map array = {
                      'id': actualUser.uid.toString(),
                      'monto': _monto
                  };

                  await event.updateData({
                    'colabs.$uid':array,
                  });

                  int monto = 0;
                  await event.get().then<dynamic>((DocumentSnapshot snapshot) async{
                    var data = snapshot.data;
                    Map colabs = data['colabs'];
                    print(colabs);
                    colabs.forEach((key,value){
                      int m = value['monto'];
                      print(m);
                      monto+=m;
                    });
                  });
                  print(monto);
                  await event.updateData({
                    'monto':monto,
                  });

                }on Exception catch(exception){
                  print(exception);
                  setState(() {
                      _error = 'Este código no existe';
                    });
                }catch(error){
                  print(error);
                  setState(() {
                    _error = 'Ha ocurrido un error. Intente nuevamente en 5 segundos';
                  });
                }

              }else{
                setState(() {
                  _error = 'Complete los campos';
                });
              }
            }
            )
        ],
      ),
    );
  }
}
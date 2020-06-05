import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fiestapp/services/database.dart';
import 'package:fiestapp/shared/constants.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewEventAlien extends StatefulWidget {
  @override
  _NewEventAlienState createState() => _NewEventAlienState();
}

class _NewEventAlienState extends State<NewEventAlien> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService databaseService = DatabaseService();
  final AuthService _auth = AuthService();
    // Form values
  int _codigo;
  int _monto;
  String _error=''; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: 
      SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Agrega un evento ajeno',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: textInputDecoration.copyWith(hintText: 'Código'),
                        validator: (val) => val.length < 1 ? 'El codigo no puede ser nulo' : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Ingresa tu presupuesto'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        validator: (val) => val.length < 1 ? 'Ingresa el monto' : null,
                        onChanged: (val) => setState(() => _monto = num.tryParse(val))
                      ),
                      SizedBox(height: 10,),


                      Text(
                          _error,
                          style: TextStyle(
                            color: Colors.red, 
                            fontSize: 14.0
                            ),
                      ),
                      
                      
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text('Agregar', style: TextStyle(color: Colors.white),),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){

                            final CollectionReference eventsCollection = Firestore.instance.collection('eventos');
                            final DocumentReference event =  Firestore.instance.collection('eventos')
                            .document('BpONI1eiXv9Q2kJ3v5vS');
                            final Query oneEvent = eventsCollection.where('codigo', isEqualTo: _codigo);
                            print(oneEvent);

                            final actualUser = await _auth.getUidUser();
                            final uid = actualUser.uid;

                            Map array = {
                                'id': actualUser.uid.toString(),
                                'monto': _monto
                            };

                                await event.updateData({
                                  'colabs.$uid':array,
                                });


                                // .add({
                                //   'colabs': array,
                                // });

                                  Navigator.pop(context);
                              }else{
                                setState(() {
                                  _error = 'Ocurrio algun error';
                                });
                              }
                        }
                        ),
                    ],
                  )
                ),
      ),
    );
  }
}
import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fiestapp/services/database.dart';
import 'package:fiestapp/shared/constants.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewEvent extends StatefulWidget {
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {

  // Need: formKey for the form, databaseService to create a new event and authService to
  // get the actual user
  final _formKey = GlobalKey<FormState>();
  final DatabaseService databaseService = DatabaseService();
  final AuthService _auth = AuthService();

    // Form values
  int _monto;
  String _nombre;
  String _error='';

  // Random for code event
  var rng = new Random();

  String numberValidator(String value) {
  if(value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if(n == null) {
    return '"$value" no es un número válido';
  }
  return null;
}

  @override
  Widget build(BuildContext context) {
    var _code = rng.nextInt(900000) + 100000;
    print('Codigooooo: $_code');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: 
      SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Agrega un evento',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Text('Codigo del evento:'),
                      TextFormField(
                        initialValue: '$_code',
                        enabled: false,
                        keyboardType: TextInputType.number,
                        decoration: textInputDecoration.copyWith(hintText: 'Código'),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Apodo del evento'),
                        validator: (val) => val.length < 1 ? 'Ingresa el apodo del evento' : null,
                        onChanged: (val) => setState(() => _nombre = val)
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Tu presupuesto'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        // validator: (val) => val < 1 ? 'Ingresa un monto' : null,
                        validator: numberValidator, 
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

                            // final CollectionReference eventsCollection = Firestore.instance.collection('eventos');

                            final actualUser = await _auth.getUidUser();

                            Map array = {
                              actualUser.uid.toString(): {
                                'id': actualUser.uid.toString(),
                                'monto': _monto
                              }
                            };

                                await Firestore.instance.collection('eventos').document('$_code')
                                .setData({
                                    'dueno': actualUser.displayName,
                                    'uid': actualUser.uid,
                                    'monto': _monto,
                                    'codigo': _code,
                                    'nombre': _nombre,
                                    'colabs': array
                                  });

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


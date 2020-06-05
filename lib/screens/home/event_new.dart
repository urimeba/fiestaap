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

  final _formKey = GlobalKey<FormState>();
  final DatabaseService databaseService = DatabaseService(uid: 'E6ZqOzGbl9ZHClRiOW8qOtgFCc13');
  final AuthService _auth = AuthService();
    // Form values
  int _monto;
  String _error='';

  var rng = new Random();

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
                      TextFormField(
                        initialValue: '$_code',
                        enabled: false,
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
                                    'dueno': actualUser.uid,
                                    'monto': _monto,
                                    'codigo': _code,
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


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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: 
      SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Agrega un evento',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Codigo del evento:',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).hintColor
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                ),
                child: TextFormField(
                  initialValue: '$_code',
                  enabled: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Código",
                    hintStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 16,
                    )
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                ),
                child: TextFormField(
                  validator: (val) => val.length < 1 ? 'Ingresa el apodo del evento' : null,
                  onChanged: (val) => setState(() => _nombre = val),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Apodo del evento",
                      hintStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 16,
                      )
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  // validator: (val) => val < 1 ? 'Ingresa un monto' : null,
                  validator: numberValidator,
                  onChanged: (val) => setState(() => _monto = num.tryParse(val)),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tu presupuesto",
                      hintStyle: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 16,
                      )
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                _error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16
                ),
              ),
              SizedBox(
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Theme.of(context).primaryColorLight,
                  child: Text(
                    'Agregar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    )
                  ),
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
                      await Firestore.instance.collection('eventos').document('$_code').setData({
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
              ),
            ],
          )
        ),
      ),
    );
  }
}


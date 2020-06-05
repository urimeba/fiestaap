import 'package:flutter/material.dart';
import 'package:fiestapp/services/database.dart';
import 'package:fiestapp/shared/constants.dart';

class NewEvent extends StatefulWidget {
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {

  final _formKey = GlobalKey<FormState>();
  final DatabaseService databaseService = DatabaseService();
    // Form values
  String _dueno;
  String _monto;
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
                        'Agrega un evento',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Dueño'),
                        validator: (val) => val.length < 1 ? 'Ingresa un dueño' : null,
                        onChanged: (val) => setState(() => _dueno = val)
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Ingresa tu presupuesto'),
                        validator: (val) => val.length < 1 ? 'Ingresa el monto' : null,
                        onChanged: (val) => setState(() => _monto = val)
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
                                await databaseService.eventsCollection
                                  .add({
                                    'dueno': _dueno,
                                    'monto': _monto
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


import 'package:flutter/material.dart';
import 'package:fiestapp/services/database.dart';
import 'package:fiestapp/shared/constants.dart';

class NewPromo extends StatefulWidget {
  @override
  _NewPromoState createState() => _NewPromoState();
}

class _NewPromoState extends State<NewPromo> {

  final _formKey = GlobalKey<FormState>();
  final List<String> stores = [
    'Oxxo',
    'Walmart',
    'Chedraui',
    'HEB',
    'Fresko',
    'SuperQ',
    'Superama',
    'La Comer'
    ];

    final DatabaseService databaseService = DatabaseService();

  // Form values
  String _descripcion;
  String _costo;
  String _fechaInicio;
  String _fechaVencimiento;
  String _tienda;
  String error="";
  DateTime _fechaInicio2 = DateTime.now();
  DateTime now = DateTime.now();
  
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fechaInicio2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _fechaInicio2)
      setState(() {
        _fechaInicio2 = picked;
        now = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    String convertedDateTime="${now.day.toString().padLeft(2,'0')}/${now.month.toString().padLeft(2,'0')}/${now.year.toString()}";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: 
      SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Agrega una promocion',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Descripcion de promoción'),
                        validator: (val) => val.length < 5 ? 'Ingresa una mejor descripcion' : null,
                        onChanged: (val) => setState(() => _descripcion = val)
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: textInputDecoration.copyWith(hintText: 'Elige una tienda'),
                        value: _tienda ?? 'Oxxo', 
                        items: stores.
                          map((store) => DropdownMenuItem(
                            child: Text('$store'),
                            value: store,
                            ))
                            .toList(),
                        onChanged: (val) => setState(() => _tienda = val)
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Costo del producto'),
                        validator: (val) => val.length < 1 ? 'Ingresa el costo del producto' : null,
                        onChanged: (val) => setState(() => _costo = val)
                      ),
                      SizedBox(height: 10,),

                      Text("$convertedDateTime"),
                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Selecciona la fecha de inicio'),
                      ),


                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Inicio de promocion'),
                        validator: (val) => val.length < 1 ? 'Ingresa la fecha de inicio' : null,
                        onChanged: (val) => setState(() => _fechaInicio = val)
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Termino de promocion'),
                        validator: (val) => val.length < 1 ? 'Ingresa la fecha de termino' : null,
                        onChanged: (val) => setState(() => _fechaVencimiento = val)
                      ),
                      Text(
                          error,
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

                          await databaseService.promosCollection
                              .add({
                                'costo': _costo,
                                'descripcion': _descripcion,
                                'estado': '1',
                                'fechaInicio': convertedDateTime ,
                                'fechaVencimiento': _fechaVencimiento,
                                'tienda': _tienda,
                              });
                              Navigator.pop(context);
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
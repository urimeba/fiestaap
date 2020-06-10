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
  String _tienda='Walmart';
  String error="";
  DateTime _fechaInicio = DateTime.now();
  DateTime _fechaFinal = DateTime.now();

  Future<Null> _selectFechaInicio(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fechaInicio,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2021));
    if (picked != null && picked != _fechaInicio)
      setState(() {
        _fechaInicio = picked;
      });
  }

  Future<Null> _selectFechaFinal(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fechaFinal,
        firstDate: _fechaInicio,
        lastDate: DateTime(2021));
    if (picked != null && picked != _fechaFinal)
      setState(() {
        _fechaFinal = picked;
      });
  }
  
  @override
  Widget build(BuildContext context) {

    String convertedFechaInicio="${_fechaInicio.day.toString().padLeft(2,'0')}/${_fechaInicio.month.toString().padLeft(2,'0')}/${_fechaInicio.year.toString()}";
    String convertedFechaFinal="${_fechaFinal.day.toString().padLeft(2,'0')}/${_fechaFinal.month.toString().padLeft(2,'0')}/${_fechaFinal.year.toString()}";


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
                'Agrega una promocion',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                ),
                child: TextFormField(
                  validator: (val) => val.length < 5 ? 'Ingresa una mejor descripcion' : null,
                  onChanged: (val) => setState(() => _descripcion = val),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Descripción de promoción",
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
                child: DropdownButtonFormField<String>(
                  //decoration: textInputDecoration.copyWith(hintText: 'Elige una tienda'),
                  value: _tienda ,
                  items: stores.map((store) => DropdownMenuItem(
                    child: Text('$store'),
                    value: store,
                  )).toList(),
                  onChanged: (val) => setState(() => _tienda = val),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Elige una tienda",
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
                  validator: (val) => val.length < 1 ? 'Ingresa el costo del producto' : null,
                  onChanged: (val) => setState(() => _costo = val),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Costo del producto",
                    hintStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 16,
                    )
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "$convertedFechaInicio",
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () => _selectFechaInicio(context),
                child: Text('Selecciona la fecha de inicio'),
              ),
              Text(
                "$convertedFechaFinal",
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 16
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () => _selectFechaFinal(context),
                child: Text('Selecciona la fecha de termino'),
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0
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
                      ),
                    ),
                    onPressed: () async {
                      if(int.parse(_fechaInicio.day.toString().padLeft(2,'0'))>int.parse(_fechaFinal.day.toString().padLeft(2,'0')) || int.parse(_fechaInicio.month.toString().padLeft(2,'0'))>int.parse(_fechaFinal.month.toString().padLeft(2,'0')) || int.parse(_fechaInicio.year.toString())>int.parse(_fechaFinal.year.toString())){
                        setState(() {
                          error="La fecha de termino NO puede ser mayor a la de inicio";
                        });
                      }else{
                        if(_formKey.currentState.validate()){
                          await databaseService.promosCollection.add({
                            'costo': _costo,
                            'descripcion': _descripcion,
                            'estado': '1',
                            'fechaInicio': convertedFechaInicio.toString() ,
                            'fechaVencimiento': convertedFechaFinal.toString(),
                            'tienda': _tienda,
                          });
                          Navigator.pop(context);
                        }
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
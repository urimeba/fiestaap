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
                        onChanged: (val) => setState(() => _codigo = num.tryParse(val))
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
                            var event;

                            try{
                              
                            event =  eventsCollection
                            .document('$_codigo');
                            }on Exception catch(exception){
                              print(exception);
                              setState(() {
                                  _error = 'Este código no existe';
                                });
                            }catch(error){
                              print(error);
                              setState(() {
                                _error = 'Este codigo no existe';
                              });
                            }

                            

                            try {
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


                              Navigator.pop(context);

                              } on Exception catch (exception) {
                                print(exception);
                                setState(() {
                                  _error = 'Este código no existe';
                                });
                              } catch (error) {
                                  setState(() {
                                    _error = 'Ha ocurrido algun error';
                                  });
                              }

                              }else{
                                setState(() {
                                  _error = 'Llena los campos correctamente';
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


class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
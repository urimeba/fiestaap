import 'package:fiestapp/shared/loading.dart';
import 'package:fiestapp/shared/constants.dart';
import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {

  final Function toggleView;
  SignUpPage({this.toggleView});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text Field states
  String email = "";
  String password = "";
  String password2 = "";
  String error = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/1.png'),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                    children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Crear Cuenta", style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ]
                    ),
              ),
              Padding(
                // padding: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'Nombre'),
                              validator: (val) => val.isEmpty ? 'Ingresa tu nombre' : null ,
                              onChanged: (val){
                                setState(() => name = val);
                              },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'Email'),
                              validator: (val) => val.isEmpty ? 'Ingresa un correo' : null ,
                              onChanged: (val){
                                setState(() => email = val);
                              },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'Contraseña'),
                              validator: (val) => val.length < 6  ? 'Ingresa una contraseña de +6 caracteres' : null ,
                              obscureText: true,
                              onChanged: (val){
                                setState(() => password = val);
                              },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'Confirmar contraseña'),
                              validator: (val) => val.length < 6  ? 'Ingresa una contraseña de +6 caracteres' : null ,
                              obscureText: true,
                              onChanged: (val){
                                setState(() => password2 = val);
                              },
                          ),
                          SizedBox(height: 5),
                          Text(
                              error,
                              style: TextStyle(
                                color: Colors.red, 
                                fontSize: 14.0
                                ),
                          ),
                          SizedBox(height: 5,),
                          RaisedButton(
                            color: Colors.pink[400],
                            onPressed: () async{
                              if(_formKey.currentState.validate()){

                                if(password==password2){
                                  setState(() => loading = true);

                                  dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);
                                  print(result);
                                  if(result==null){
                                    setState((){
                                      error = 'Por favor, ingresa un correo válido';
                                      loading = false;
                                      }
                                    );
                                  }

                                }else{
                                  setState(() {
                                    error = 'Las contraseñas no coinciden';
                                    loading = false;
                                  });
                                  
                                }



                                

                                
                              }
                            },
                            child: Text(
                              'Registrame',
                              style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 1),
                            
                            // SizedBox(height: 1),
                            FlatButton.icon(
                                onPressed: () => widget.toggleView(),
                                icon: Icon(Icons.person), 
                                label: Text('Ya tengo cuenta')
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                )

            ],
          ),
        ),

      ),

    );
  }
}
import 'package:fiestapp/screens/loading.dart';
import 'package:flutter/material.dart';



class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  // Values inputs
  String email = "";
  String password = "";
  String error = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/1.png'),
                    fit: BoxFit.cover
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin:  EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[300], width: 2)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2)
                                )
                              ).copyWith(hintText: 'Email'),
                              validator: (val) => val.isEmpty ? 'Ingresa tu correo' : null,
                              onChanged: (val){
                                setState(() => email = val);
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder( 
                                  borderSide: BorderSide(
                                    color: Colors.grey[300],
                                    width: 2
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue, 
                                    width: 2
                                    ),
                                )
                              ).copyWith(hintText: 'Contraseña'),
                              validator: (val) => val.length < 6 ? 'Ingresa tu contraseña de +6 caracteres' : null,
                              obscureText: true,
                              onChanged: (val){
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(height: 20),
                            RaisedButton(
                              child: Text(
                                'Iniciar sesión',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.pink[400],
                              onPressed: () async{

                                if(_formKey.currentState.validate()){
                                  print(email);
                                  print(password);


                                }else{
                                  setState(() {
                                    error='No se pudo logear';
                                    loading=false;
                                  });
                                }

                                

                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              error,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14
                              ),
                            ),

                            SizedBox(height: 5),
                            FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.person), 
                                label: Text('Register')
                                )
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
                ),
            ],

          ),
        ),
        
      ),
      
    );
  }
}
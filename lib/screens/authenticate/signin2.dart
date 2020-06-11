import 'package:fiestapp/shared/loading.dart';
import 'package:fiestapp/shared/constants.dart';
import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {

  final Function toggleView;
  SignInPage({this.toggleView});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final AuthService _auth = AuthService();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  // Values inputs
  String email = "";
  String password = "";
  String error = "";

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
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Correo",
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 16,
                                    )
                                ),
                                validator: (val) => val.isEmpty ? 'Ingresa tu correo' : null,
                                onChanged: (val){
                                  setState(() => email = val);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Contraseña",
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 16,
                                    )
                                ),
                                validator: (val) => val.length < 6 ? 'Ingresa tu contraseña de +6 caracteres' : null,
                                obscureText: true,
                                onChanged: (val){
                                  setState(() => password = val);
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: 200,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Theme.of(context).primaryColorLight,
                                child: Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () async{
                                  if(_formKey.currentState.validate()){
                                    setState(() => loading = true);
                                    dynamic result = await _auth.signInWithEmailAndPassword(email.trim(), password);

                                    if(result==null){
                                      setState(() {
                                        error = 'Usuario o contraseña incorrectos';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              error,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16
                              ),
                            ),
                            SizedBox(height: 5),
                            FlatButton.icon(
                              onPressed: () => widget.toggleView(),
                              icon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              label: Text(
                                'No tengo cuenta',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight
                                ),
                              )
                            ),
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

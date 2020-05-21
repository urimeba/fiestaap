import 'package:fiestapp/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
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
                    )
                ),
                child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Iniciar Sesión", style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            )),
                          ),
                        )),
                      )]),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(1.6, Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(5, 20, 79, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Correo",
                                  hintStyle: TextStyle(color: Theme.of(context).hintColor)
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Contraseña",
                                  hintStyle: TextStyle(color: Theme.of(context).hintColor)
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                    SizedBox(height: 30,),
                    FadeAnimation(1.6, Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColorLight,
                              ]
                          )
                      ),
                      child: Center(
                        child: Text("Entrar", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ),
                    )),
                    SizedBox(height: 70,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Center(
                          child: FlatButton(
                            child: Container(
                              child: FadeAnimation(1.6, Text("Olvidé mi contraseña", style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ))),
                            ),
                          ),
                        ),
                        Center(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/registro');
                            },
                            child: Container(
                              child: FadeAnimation(1.6, Text("Crear cuenta", style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ))),
                            ),
                          ),
                        ),
                      ],
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
import 'package:flutter/material.dart';



class SignUpPage extends StatefulWidget {

  final Function toggleView;
  SignUpPage({this.toggleView});


  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

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
    return Scaffold(
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
                    // Container(
                    //   padding: EdgeInsets.all(5),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(10),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Color.fromRGBO(5, 20, 79, .2),
                    //         blurRadius: 20.0,
                    //         offset: Offset(0, 10)
                    //         )]
                    //   ),
                    // ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
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
                              ).copyWith(hintText: 'Nombre'),
                              validator: (val) => val.isEmpty ? 'Ingresa tu nombre' : null ,
                              onChanged: (val){
                                setState(() => name = val);
                              },
                          ),
                          SizedBox(height: 20),
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
                              ).copyWith(hintText: 'Email'),
                              validator: (val) => val.isEmpty ? 'Ingresa un correo' : null ,
                              onChanged: (val){
                                setState(() => email = val);
                              },
                          ),
                          SizedBox(height: 20),
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
                              validator: (val) => val.length < 6  ? 'Ingresa una contraseña de +6 caracteres' : null ,
                              onChanged: (val){
                                setState(() => password = val);
                              },
                          ),
                          SizedBox(height: 20),
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
                              ).copyWith(hintText: 'Confirmar contraseña'),
                              validator: (val) => val.length < 6  ? 'Ingresa una contraseña de +6 caracteres' : null ,
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
                                print(name);
                                print(email);
                                print(password);
                                print(password2);
                              }else{
                                setState(() {
                                  error = 'Error al registrarse';
                                  loading = false;
                                });
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
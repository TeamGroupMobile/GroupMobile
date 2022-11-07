import 'package:ejemplo_2/modelos/user.dart';
import 'package:ejemplo_2/repositorio/registrousuariofirebase.dart';
import 'package:ejemplo_2/vistas/vistapoi.dart';
import 'package:ejemplo_2/vistas/vistaregistro.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ejemplo_2/firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';


class VistaLogin extends StatefulWidget {
  const VistaLogin({Key? key}) : super(key: key);

  @override
  State<VistaLogin> createState() => _VistaLoginState();
}

class _VistaLoginState extends State<VistaLogin> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final usuario = TextEditingController();
  final _passwordclave = TextEditingController();
  String usu="";
  String clave="";
  Usuario userloader = Usuario.Empty();
  obtenerUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    userloader = Usuario.fromJson(userMap);
  }
  void validarUser (){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VistaPoi()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                            "imagenes/viaje.jpg",
                          )),
                    ),
                  ),
                  TextFormField(
                    controller: usuario,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correo electrónico'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passwordclave,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Contraseña'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        validarUser();
                      },
                      child: const Text('Iniciar sesión')),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue)),
                    onPressed: () async {
                      usu = usuario.text;
                      clave = clave;
                      final datos = await firebaseAuth
                          .signInWithEmailAndPassword(
                          email: usu, password: clave);
                      print(datos);
                      if (datos != null) {
                        print(usu);
                        print(clave);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VistaRegistro()));
                    },


                    child: const Text('Registrese'),

                  ),
                ],
              ),
            ),
          ),
        )
    );

  }
}

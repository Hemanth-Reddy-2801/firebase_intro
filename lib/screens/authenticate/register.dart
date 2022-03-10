// ignore_for_file: prefer_const_constructors

import 'package:firebase_intro/services/auth.dart';
import 'package:firebase_intro/shared/constants.dart';
import 'package:firebase_intro/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggle;

  Register({required this.toggle});

  //const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggle();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign in"))
              ],
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign up to brew'),
            ),
            body: Container(
              //this formkey keeps track of our form , in future if we want to validate our form we can do it via this _formkey

              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //copywith adds the mentioned hinttext property to the saved constant textInputDecoration
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        //validator will be valid if it recieves null from each
                        validator: (val) =>
                            val!.isEmpty ? "enter your email" : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        //obscure text is for passwords where the value typed is showed as dots
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? "enter a password more than 6 chars"
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            //_formkey.currentState gives the current state of the form above and validate() validates it
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error = "please enter a valid email id";
                                  loading = false;
                                });
                              }
                            }
                          }),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  )),
              // signing in anonymously
              // child: RaisedButton(
              //   child: Text('sign in anon'),
              //   onPressed: () async {
              //     dynamic result = await _auth.signInAnon();
              //     if (result == null) {
              //       print('error signing in');
              //     } else {
              //       print('signed in');
              //       print(result.uid);
              //     }
              //   },
              // ),
            ),
          );
  }
}

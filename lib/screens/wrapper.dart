import 'package:firebase_intro/models/user.dart';
import 'package:firebase_intro/screens/authenticate/authenticate.dart';
import 'package:firebase_intro/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr?>(context);

    //return either authenticate or home widget
    return user == null ? Authenticate() : Home();
  }
}

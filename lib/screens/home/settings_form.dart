// ignore_for_file: unused_field, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, deprecated_member_use

import 'package:firebase_intro/models/user.dart';
import 'package:firebase_intro/services/database.dart';
import 'package:firebase_intro/shared/constants.dart';
import 'package:firebase_intro/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr?>(context);

    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user!.uid).userData,
        //this snapshot is the snapshot coming from the stream not the one from the firebase
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (value) => setState(() {
                      _currentName = value;
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text('$sugar sugars'));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _currentSugars = value!;
                      });
                    },
                  ),
                  //slider
                  Slider(
                    thumbColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (value) {
                      setState(() {
                        _currentStrength = value.round();
                      });
                    },
                    value: (_currentStrength ?? userData.strength).toDouble(),
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child:
                          Text('Update', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

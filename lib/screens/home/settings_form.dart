import 'package:firebase/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase/shared/loading.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  final List<String> dishs = [
    'Rice',
    'dosa',
    'fried rice',
    
  ];

  String _currentName;
  String _currentdishs;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    'update your iceCream settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentdishs ?? userData.dishs,
                    items: dishs.map((dish) {
                      return DropdownMenuItem(
                        value: dish,
                        child: Text('$dish '),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentdishs = val),
                  ),
                  RaisedButton(
                    color: Colors.pink,
                    child:
                        Text('update', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentdishs ?? userData.dishs,
                          _currentName ?? userData.name,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

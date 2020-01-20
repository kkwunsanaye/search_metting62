import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Field

// Method
  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextFormField(
        decoration: InputDecoration(hintText: 'User:'),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextFormField(
        decoration: InputDecoration(hintText: 'Password:'),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showText() {
    return Text(
      'kamthornAuthen',
      style: TextStyle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showLogo(),
            showText(),
            userForm(),
            passwordForm(),
          ],
        ),
      ),
    );
  }
}

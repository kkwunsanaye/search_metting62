import 'package:flutter/material.dart';
import 'package:kamthornsenate/screens/my_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // var materialApp = MaterialApp(  ทำเกินแน่
     return MaterialApp(
     home: MyService(),
    );
    
  }
}

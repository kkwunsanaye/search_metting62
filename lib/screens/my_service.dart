import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kamthornsenate/models/data_model.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}
class _MyServiceState extends State<MyService> {
  // field
  String url =
      'http://w3c.senate.go.th/dbrulessenate/search_senate2562.php?kw=';
  List<DataModel> dataModels = List();
  String search = '';
  final formKey = GlobalKey<FormState>();

  // method
  @override
  void initState() {
    super.initState();
    readAllData();
  }
  Future<void> readAllData() async {
    String url2 = '$url$search';
    if (dataModels.length !=0) {
      dataModels.removeWhere((DataModel dataModel){
        return dataModel !=null;});
    }
    Response response = await Dio().get(url2);
    var result = json.decode(response.data);
    print('result ===>>> $result');
    for (var map in result) {
      DataModel dataModel = DataModel.fromJson(map);
      setState(() {
        dataModels.add(dataModel);
      });
    }
  }

 Widget showNumberTH(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            dataModels[index].numberTH,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade200),
          ),
        ),
      ],
    );
  }

  Widget showTitle(int index ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            dataModels[index].dataTitle,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800),
          ),
        ),
      ],
    );
  }
Widget showTitleDetail(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          width: MediaQuery.of(context).size.width - 30,
          child: Text(
            dataModels[index].numberTH,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade500),
          ),
        ),
      ],
    );
  }



 
  Widget showDataDetail(int index) {
    String string = dataModels[index].dataDetail;
    if (string.length > 70) {
      string = string.substring(0, 70);
      string = '$string...';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(left: 10.0,right: 5.0, top: 5.0, bottom: 5.0),
          width: MediaQuery.of(context).size.width - 30,
          child: Text(
            string,
            style: TextStyle(
                fontSize: 18.0,
               // fontWeight: FontWeight.bold,
                color: Colors.green.shade900,),
          ),
        ),
      ],
    );
  }

  Widget showListView(int index) {
    return Container(
      margin: EdgeInsets.all(1.0),
      child: Card(
        color: index % 2 == 0 ? Colors.green.shade50 : Colors.green.shade100,
        child: Column(
          children: <Widget>[
              showNumberTH(index),
              showTitle(index),
              showTitleDetail(index),
              showDataDetail(index),
          ],
        ),
      ),
    );
  }

  Widget searchButton() {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        formKey.currentState.save();
      },
    );
  }
  Widget searchForm() {
    return Form(
      key: formKey,
      child: TextFormField(
        onSaved: (String string) {
          search = string.trim();
          readAllData();
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: 'search',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[searchButton()],
        title: searchForm(),
      ),
      body: ListView.builder(
        itemCount: dataModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return showListView(index);
        },
      ),
    );
  }
}

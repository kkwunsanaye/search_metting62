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
  final formKey = GlobalKey<FormState>();// อ่าน api

  // method (ทำงานไม่สนใจผลลัพธ์ ปิดไฟ)
  @override
  void initState() {
    super.initState();
    readAllData(); // initstate ให้ readAllData ทำงานให้เสร็จ ทำตรงนี้ก่อน build
  }
  Future<void> readAllData() async { // สร้างเทรด เพื่อทำงานให้เสร็จ (เทรดทำงานสนใจผลลัพธ์)
    String url2 = '$url$search'; // url2 เกิดจากเอาค่า url และตามด้วยค่า search
    if (dataModels.length !=0) {// ถ้ามีค่าไม่เท่ากับศูนย์จะทำงานในเคอรีบักเก็ต
      dataModels.removeWhere((DataModel dataModel){//
        return dataModel !=null;});//วิ่งมารอบแรกสร้าง array แล้วพอ synchroni ใหม่มันจะเคลียของเก่า สรุปเข้ามาไม่เท่ากับศูนย์ลบทิ้ง
    }// ตัวอย่างเมื่อกดเลข 1 จะมาเฉพาะเลข 1 เท่านั้น
    Response response = await Dio().get(url2); //เชื่อมต่อกับ server
    var result = json.decode(response.data); // สร้างตัวแปร และ decode json มาใช้
    print('result ===>>> $result');// $ นำค่่าของ result มาแสดง
    for (var map in result) {  // เว็บไซต์เรียก json flutter เรียก map
      DataModel dataModel = DataModel.fromJson(map);//เอาค่่าที่อยู่ใน json เข้าไป dataModel
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
    var container = Container(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            dataModels[index].dataTitle,//เอาค่า dataTitle ใน dataModels มาดอทฟิวจะได้ฟิวออกมา
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800),
          ),
        );
    var row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        container,
      ],
    );
    return row;
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
    String string = dataModels[index].dataDetail;//จาก dataModel แสดงเฉพาะค่า string
    if (string.length > 100) {//มากกว่า 100 ให้ตัดคำที่ตำแหน่งที่ 10 และ 80 และมีค่า ... 
      string = string.substring(10, 80); //
      string = '$string...';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(left: 5.0,right: 5.0, top: 5.0, bottom: 5.0),// ห่างจากซ้าย ขวา บน ล่าง
          width: MediaQuery.of(context).size.width - 30,// mediaQuery ความก้วางเท่าหน้าจอ
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
      margin: EdgeInsets.all(2.0),
      child: Card(
        color: index % 2 == 0 ? Colors.green.shade50 : Colors.green.shade100, borderOnForeground: true, 
        child: Column( //เอาตัวแปร int มามอดเูลตกับ 2 ซึ่งมี 2 ค่า
          children: <Widget>[  //ได้ศูนย์ก็หนึ่ง ซึ่งทำงานแล้วมีค่าเท่ากับศูนย์ ถ้าไม่ถูกต้องทำงานหลังเครื่องหมายโคลอน
              //showNumberTH(index),
              //showTitle(index),
              //showTitleDetail(index),
              showDataDetail(index),
          ],
        ),
      ),
    );
  }

 Widget searchButton() {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {// กดแล้วได้อะไร
        formKey.currentState.save();//ให้ onPressed ทำงานเมื่อกดเลข 1 แล้วแสดงผล
      },
    );
  }
  Widget searchForm() { //ชื่อเมทอด searchForm
    return Form(
      key: formKey,
      child: TextFormField(
        onSaved: (String string) {//ถ้าคลิกที่ปุ่มจะให้ทำงานที่ onSaved และสิ่งที่กรอกจะไปอยู่ใน ฟอร์มดีย์
          search = string.trim();//ตัดช่องว่างข้างหน้าและด้านหลัง
          readAllData();//เป็นการ set state และให้ทำการดึงข้อมูลใหม่ readAllData
        },
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(//
            hintText: 'search',//
            hintStyle: TextStyle(color: Colors.black),//hintStyle คือตัวอักษรสีดำ
            border: InputBorder.none,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[searchButton()],//เอา searchButton มาใส
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

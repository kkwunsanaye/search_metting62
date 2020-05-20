import 'package:flutter/material.dart';
import 'package:kamthornsenate/models/data_model.dart';

class Detail extends StatefulWidget {
  final DataModel dataModel;  //ชื่อ dataModel 
  Detail({Key key, this.dataModel}); // สร้างขึ้น

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
// Field
  DataModel currentModel; // สร้างขึ้น
// method
  @override
  void initState() {   // สร้างขึ้นเพื่อ
    super.initState();  // สร้างขึ้น
    currentModel = widget.dataModel;// สร้างตัวแปร currentModel และเอาค่า dataModel มาไว้ตัวล่าง
  }
// มันคือ method ที่ทำงานก่อน build ทำงาน
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(currentModel.dataDetail),
      ),
    );
  }
}

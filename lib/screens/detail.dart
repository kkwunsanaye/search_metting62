import 'package:flutter/material.dart';
import 'package:kamthornsenate/models/data_model.dart';

class Detail extends StatefulWidget {
  final DataModel dataModel;
  Detail({Key key, this.dataModel});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
// Field
  DataModel currentModel;

// method
  @override
  void initState() {
    super.initState();
    currentModel = widget.dataModel;
  }

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

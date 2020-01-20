class DataModel {
  String iD;
  String numberEN;
  String numberTH;
  String dataTitle;
  String dataTitledetail;
  String dataDetail;

  DataModel(
      {this.iD,
      this.numberEN,
      this.numberTH,
      this.dataTitle,
      this.dataTitledetail,
      this.dataDetail});

  DataModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    numberEN = json['NumberEN'];
    numberTH = json['NumberTH'];
    dataTitle = json['data_title'];
    dataTitledetail = json['data_titledetail'];
    dataDetail = json['data_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NumberEN'] = this.numberEN;
    data['NumberTH'] = this.numberTH;
    data['data_title'] = this.dataTitle;
    data['data_titledetail'] = this.dataTitledetail;
    data['data_detail'] = this.dataDetail;
    return data;
  }

  void add(DataModel dataModel) {}
}


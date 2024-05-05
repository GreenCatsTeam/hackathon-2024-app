import 'dart:convert';

class sendTrashModel {
  String? comment;
  String? city;
  String? district;
  int? index;
  String? image;

  sendTrashModel(
  {this.comment,
    this.city,
    this.district,
    this.index,
    this.image
  });
  //Map<String, dynamic> sendTrashModel.toJson() {
    //final Map<String, dynamic> json = new Map<String, dynamic>();
    //this.comment = json['comment'];
   // this.city= json['city'];
    ///district = json['district'];
   // index = json['index'];
   // image=json['image'];
   // return json;
  }
 //sendTrashModel.toJson(Map<String, dynamic> json) {
    //comment = json['comment'];
    //city= json['city'];
    //district = json['district'];
    //index = json['index'];
    //image=json['image'];
  //}

 //}

Map<String, dynamic> toJsons(String image) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['image'] = image;
  return data;
}

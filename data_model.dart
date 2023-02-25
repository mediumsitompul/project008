class DataModel{
  String sn1, name1, address1, latLng1;


  DataModel({
    this.sn1="",
    this.name1="",
    this.address1="",
    this.latLng1="",
  });

  factory DataModel.fromJSON1(Map<String, dynamic>json){
    return DataModel(
      sn1: json["sn"],
      name1: json["name"],
      address1: json["address"],
      latLng1: json["lat_lng"],
    );
  }
}

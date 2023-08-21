class RawModel{
  late int? gula, coklat, keju, terigu, stroberi, telur;
  RawModel({this.coklat,this.gula,this.keju,this.stroberi,this.telur,this.terigu});
  
  factory RawModel.FromJSON(Map<String, dynamic> json){
    return RawModel(
      gula: json['gula'],
      terigu: json['terigu'],
      keju: json['keju'],
      coklat: json['gula'],
      stroberi: json['stroberi'],
      telur: json['telur'],
    );
  }
}
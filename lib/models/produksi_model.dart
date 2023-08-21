class ProduksiModel{
  late int? rotikeju, roticoklat, rotistroberi;
  ProduksiModel({this.roticoklat,this.rotikeju,this.rotistroberi});
  factory ProduksiModel.FromJSON(Map<String, dynamic> json){
    return ProduksiModel(
      roticoklat: json['roticoklat'],
      rotikeju: json['rotikeju'],
      rotistroberi: json['rotistroberi']
    );
  }
}
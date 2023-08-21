class ProdukModel{
  late String? produk;
  late int? stok,harga;

  ProdukModel({this.harga,this.produk,this.stok});

  factory ProdukModel.FromJSON(Map<String, dynamic>json){
    return ProdukModel(
      produk: json["produk"],
      harga: json["harga"],
      stok: json["stok"]
    );
  }
}
class OrderModel{
  late String? id,namaPembeli,alamat,produk,tanggal,email;
  late int? jumlah,total;
  late bool? state;

  OrderModel({this.id,this.alamat,this.jumlah, this.namaPembeli,this.produk,this.state,this.tanggal,this.total,this.email});

  factory OrderModel.FromJSON(Map<String, dynamic> json){
    return OrderModel(
      id: json['_id'],
      alamat: json['alamat'],
      jumlah: json['jumlah'],
      email: json['email'],
      namaPembeli: json['namaPembeli'],
      produk: json['produk'],
      tanggal: json['tanggal'],
      total: json['total'],
      state: json['state']
    );
  }
}
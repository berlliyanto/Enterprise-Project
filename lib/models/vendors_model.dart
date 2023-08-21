class VendorModel{
  late String? name, vendorName,website,phone,email;

  VendorModel({this.name,this.email,this.phone,this.vendorName,this.website});

  factory VendorModel.FromJSON(Map<String, dynamic> json){
    return VendorModel(
      name: json['name'],
      email: json['email'],
      vendorName: json['vendor_name'],
      website: json['website'],
      phone: json['phone']
    );
  }
}
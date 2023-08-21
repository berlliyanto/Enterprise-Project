class ActivitiesModel{
  late String? name, tenggat, status, tugas, prioritas;
  ActivitiesModel({this.name,this.prioritas,this.status,this.tenggat,this.tugas});

  factory ActivitiesModel.FromJSON(Map<String, dynamic> json){
    return ActivitiesModel(
      name: json['name'],
      tenggat: json['tenggat'],
      prioritas: json['prioritas'],
      status: json['status'],
      tugas: json['tugas']
    );
  }
}
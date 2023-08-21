class MachineModel{
  late bool? oven,mixer,proofer,pembagi;

  MachineModel({this.mixer,this.oven,this.pembagi,this.proofer});

  factory MachineModel.FromJSON(Map<String, dynamic>json){
    return MachineModel(
      oven: json['oven'],
      mixer: json['mixer'],
      proofer: json['proofer'],
      pembagi: json['pembagi']
    );
  }
}
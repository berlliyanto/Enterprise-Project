// ignore_for_file: camel_case_types, non_constant_identifier_names

class userModel{
  late String? username,password,level,id;
  
  userModel({this.id,this.level, this.password, this.username});

  factory userModel.FromJSON(Map<String, dynamic> json){
    return userModel(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      level: json['level'],
    );
  }
}
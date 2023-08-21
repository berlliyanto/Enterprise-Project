class LeadModel {
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? id;

  LeadModel({
    this.firstName,
    this.lastName,
    this.email,
    this.id,
  });

  factory LeadModel.FromJSON(Map<String, dynamic> json) {
    return LeadModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      id: json['id'],
      email: json['email']
    );
  }
}

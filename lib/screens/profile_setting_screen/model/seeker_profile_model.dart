class ProfileSettingModel {
  String name;
  int age;
  String address;
  String occupation;

  ProfileSettingModel({
    required this.name,
    required this.age,
    required this.address,
    required this.occupation,
  });

  factory ProfileSettingModel.fromJson(Map<String, dynamic> json) =>
      ProfileSettingModel(
        name: json['name'],
        age: json['age'],
        address: json['address'],
        occupation: json['occupation'],
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'address': address,
      'occupation': occupation,
    };
  }
}

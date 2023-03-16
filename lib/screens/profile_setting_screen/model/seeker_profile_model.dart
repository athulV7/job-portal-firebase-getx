class ProfileSettingModel {
  String? profilePic;
  String name;
  int age;
  String address;
  String occupation;

  ProfileSettingModel({
    this.profilePic,
    required this.name,
    required this.age,
    required this.address,
    required this.occupation,
  });

  factory ProfileSettingModel.fromJson(Map<String, dynamic> json) =>
      ProfileSettingModel(
        profilePic: json['profilePic'],
        name: json['name'],
        age: json['age'],
        address: json['address'],
        occupation: json['occupation'],
      );

  Map<String, dynamic> toJson() {
    return {
      'profilePic': profilePic,
      'name': name,
      'age': age,
      'address': address,
      'occupation': occupation,
    };
  }
}

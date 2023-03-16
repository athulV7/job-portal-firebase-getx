class RecruiterProfileModel {
  String? profilePic;
  String companyName;
  String companyEmail;
  String establishedDate;
  String companyAddress;
  String country;

  RecruiterProfileModel({
    this.profilePic,
    required this.companyName,
    required this.companyEmail,
    required this.establishedDate,
    required this.companyAddress,
    required this.country,
  });

  factory RecruiterProfileModel.fromJson(Map<String, dynamic> json) =>
      RecruiterProfileModel(
        profilePic: json['profilePic'],
        companyName: json['companyName'],
        companyEmail: json['companyEmail'],
        establishedDate: json['establishedDate'],
        companyAddress: json['companyAddress'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() {
    return {
      'profilePic': profilePic,
      'companyName': companyName,
      'companyEmail': companyEmail,
      'establishedDate': establishedDate,
      'companyAddress': companyAddress,
      'country': country,
    };
  }
}

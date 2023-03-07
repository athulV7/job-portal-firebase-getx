class RecruiterProfileModel {
  String companyName;
  String companyEmail;
  String establishedDate;
  String companyAddress;
  String country;

  RecruiterProfileModel({
    required this.companyName,
    required this.companyEmail,
    required this.establishedDate,
    required this.companyAddress,
    required this.country,
  });

  factory RecruiterProfileModel.fromJson(Map<String, dynamic> json) =>
      RecruiterProfileModel(
        companyName: json['companyName'],
        companyEmail: json['companyEmail'],
        establishedDate: json['establishedDate'],
        companyAddress: json['companyAddress'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyEmail': companyEmail,
      'establishedDate': establishedDate,
      'companyAddress': companyAddress,
      'country': country,
    };
  }
}

class MoreDetailsModel {
  String skills;
  String education;
  String experience;
  int contactNo;

  MoreDetailsModel({
    required this.skills,
    required this.education,
    required this.experience,
    required this.contactNo,
  });

  factory MoreDetailsModel.fromJson(Map<String, dynamic> json) =>
      MoreDetailsModel(
        skills: json['skills'],
        education: json['education'],
        experience: json['experience'],
        contactNo: json['contactNo'],
      );

  Map<String, dynamic> toJson() {
    return {
      'skills': skills,
      'education': education,
      'experience': experience,
      'contactNo': contactNo,
    };
  }
}

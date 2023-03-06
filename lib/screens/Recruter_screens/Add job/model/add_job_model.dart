class AddJobModel {
  String title;
  String description;
  String salary;
  int positions;
  String qualification;
  String experience;
  String? jobType;
  String companyName;
  String location;
  String? industry;
  String createdTime;

  AddJobModel({
    required this.title,
    required this.description,
    required this.salary,
    required this.positions,
    required this.qualification,
    required this.experience,
    required this.jobType,
    required this.companyName,
    required this.location,
    required this.industry,
    required this.createdTime,
  });

  factory AddJobModel.fromJson(Map<String, dynamic> json) => AddJobModel(
        title: json['title'],
        description: json['description'],
        salary: json['salary'],
        companyName: json['companyName'],
        experience: json['experience'],
        industry: json['industry'],
        jobType: json['jobType'],
        location: json['location'],
        positions: json['positions'],
        qualification: json['qualification'],
        createdTime: json['createdTime'],
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'salary': salary,
      'companyName': companyName,
      'experience': experience,
      'industry': industry,
      'jobType': jobType,
      'location': location,
      'positions': positions,
      'qualification': qualification,
      'createdTime': createdTime,
    };
  }
}

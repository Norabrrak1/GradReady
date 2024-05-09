class PostModel {
  String? title;
  String? description;
  String? location;
  String? start;
  String? type;
  String? gpa;
  String? level;
  String? skills;
  String? uidCompany;
  String? uid;
  String? image;
  String? companyName;
  String? end;
  String? status;

  PostModel(
      {this.title,
        this.location,
        this.description,
        this.gpa,
        this.start,
        this.level,
        this.type,
        this.skills,
        this.uidCompany,
        this.uid,
        this.image,
        this.companyName,
        this.end,
        this.status,
      });

  PostModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
    location = json['location'];
    type = json['type'];
    start = json['start'];
    level = json['level'];
    gpa = json['gpa'];
    skills = json['skills'];
    uidCompany = json['uidCompany'];
    uid = json['uid'];
    image = json['image'];
    companyName = json['companyName'];
    end = json['end'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'type': type,
      'start': start,
      'level': level,
      'gpa': gpa,
      'skills': skills,
      'uidCompany': uidCompany,
      'uid': uid,
      'image': image,
      'companyName': companyName,
      'end': end,
      'status': status,
    };
  }
}

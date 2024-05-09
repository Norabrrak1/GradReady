class ApplicantsModel {
  String? email;
  String? location;
  String? uidUser;
  String? type;
  String? gpa;
  String? level;
  String? skills;
  String? uidCompany;
  String? uid;
  String? name;
  String? status;
  String? start;
  String? end;
  String? image;
  String? description;
  String? title;
  String? display;

  ApplicantsModel({
    this.location,
    this.email,
    this.gpa,
    this.uidUser,
    this.level,
    this.type,
    this.skills,
    this.uidCompany,
    this.uid,
    this.name,
    this.description,
    this.image,
    this.title, this.end, this.start,
    this.status,
    this.display,
  });

  ApplicantsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    location = json['location'];
    type = json['type'];
    uidUser = json['uidUser'];
    level = json['level'];
    gpa = json['gpa'];
    skills = json['skills'];
    uidCompany = json['uidCompany'];
    uid = json['uid'];
    name = json['name'];
    status = json['status'];
    image = json['image'];
    start = json['start'];
    end = json['end'];
    title = json['title'];
    description = json['description'];
    display = json['display'];
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'email': email,
      'level': level,
      'gpa': gpa,
      'skills': skills,
      'uidCompany': uidCompany,
      'uidUser': uidUser,
      'name': name,
      'type': type,
      'uid': uid,
      'status': status,
      'image': image,
      'description': description,
      'start': start,
      'end': end,
      'title': title,
      'display': display,
    };
  }
}

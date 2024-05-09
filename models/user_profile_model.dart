class UserProfileModel {
  String? gender;
  String? email;
  String? name;
  String? birth;
  String? uid;
  String? phone;
  String? location;
  List? skills;
  List? interests;
  List? language;
  String? image;

  UserProfileModel({
    this.gender,
    this.email,
    this.phone,
    this.name,
    this.birth,
    this.uid,
    this.skills,
    this.location,
    this.interests,
    this.language,
    this.image,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    birth = json['birth'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    language = json['language'];
    interests = json['interests'];
    location = json['location'];
    uid = json['uid'];
    skills = json['skills'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'birth': birth,
      'email': email,
      'name': name,
      'phone': phone,
      'language': language,
      'interests': interests,
      'location': location,
      'uid': uid,
      'skills': skills,
      'image': image,

    };
  }
}

class EducationModel {
  String? major;
  String? university;
  String? start;
  String? end;
  String? numYears;
  String? uidUser;
  String? uid;

  EducationModel({
    this.major,
    this.university,
    this.start,
    this.end,
    this.numYears,
    this.uidUser,
    this.uid,
  });

  EducationModel.fromJson(Map<String, dynamic> json) {
    major = json['major'];
    numYears = json['numYears'];
    end = json['end'];
    university = json['university'];
    start = json['start'];
    uidUser = json['uidUser'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'major': major,
      'numYears': numYears,
      'university': university,
      'end': end,
      'start': start,
      'uidUser': uidUser,
      'uid': uid,
    };
  }
}

class UserModel {
  String? type;
  String? email;
  String? name;
  String? password;
  String? uid;


  UserModel({
    this.type,
    this.email,
    this.uid,
    this.name,
    this.password,

  });

  UserModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    uid = json['uid'];

  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'password': password,
      'email': email,
      'name': name,
      'uid': uid,
    };
  }
}

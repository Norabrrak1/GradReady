class CompanyModel {
  String? field;
  String? name;
  String? uid;
  String? about;
  String? mission;
  String? image;
  String? contact;

  CompanyModel(
      {this.field,
      this.uid,
      this.name,
      this.image,
      this.about,
      this.contact,
      this.mission});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    field = json['field'];
    uid = json['uid'];
    mission = json['mission'];
    about = json['about'];
    contact = json['contact'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'name': name,
      'uid': uid,
      'mission': mission,
      'about': about,
      'contact': contact,
      'image': image,
    };
  }
}

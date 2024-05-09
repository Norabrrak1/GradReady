class CourseModel {
  String? title;
  String? uid;
  String? link;
  String? capacity;
  String? location;
  String? description;
  String? image;
  String? type;
  String? price;

  CourseModel({
    this.uid,
    this.link,
    this.capacity,
    this.title,
    this.location,
    this.description,
    this.image,
    this.type,
    this.price,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    uid = json['uid'];
    title = json['title'];
    location = json['location'];
    capacity = json['capacity'];
    description = json['description'];
    image = json['image'];
    price = json['price'];

    type = json['type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'link': link,
      'uid': uid,
      'title': title,
      'location': location,
      'capacity': capacity,
      'description': description,
      'image': image,
      'type': type,
      'price': price,
    };
  }
}

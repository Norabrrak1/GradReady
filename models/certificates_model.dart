class CertificatesModel {
  String? title;
  String? uid;
  String? link;
  String? capacity;

  String? description;
  String? image;

  String? price;

  CertificatesModel({
    this.uid,
    this.link,
    this.capacity,
    this.title,
    this.description,
    this.image,
    this.price,
  });

  CertificatesModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    uid = json['uid'];
    title = json['title'];
    capacity = json['capacity'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'link': link,
      'uid': uid,
      'title': title,
      'capacity': capacity,
      'description': description,
      'image': image,
      'price': price,
    };
  }
}

// ignore_for_file: body_might_complete_normally_catch_error, use_build_context_synchronously
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/models/course_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/certificates_model.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit get(context) => BlocProvider.of(context);

  File? itemImageFile;
  String? itemImage;
  List<CourseModel> coursesList = [];
  List<CertificatesModel> certificatesList = [];

  showBottomSheet(BuildContext context) {
    ImagePicker picker = ImagePicker();
    XFile? file;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    file = await picker.pickImage(source: ImageSource.gallery);

                    Navigator.pop(context);
                    getImage(file);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.photo_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "From Gallery",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    file = await picker.pickImage(source: ImageSource.camera);
                    Navigator.pop(context);
                    getImage(file);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "From Camera",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> getImage(final file) async {
    if (file != null) {
      itemImageFile = File(file.path);
      if (kDebugMode) {
        print(file.path);
      }
      emit(GetImageSuccessState());
      uploadImage();
    } else {
      if (kDebugMode) {
        emit(GetImageErrorState('No image selected'));
        print('No image selected');
      }
    }
  }

  void uploadImage() {
    emit(UploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('/image${Uri.file(itemImageFile!.path).pathSegments.last}')
        .putFile(itemImageFile!)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      value.ref.getDownloadURL().then((value) {
        itemImage = value;
      }).catchError((error) {
        emit(UploadImageErrorState(error.toString()));
      });
      emit(UploadImageSuccessState());
    }).catchError((error) {
      emit(UploadImageErrorState(error.toString()));
    });
  }

  addCourse({
    required String title,
    required String link,
    required String location,
    required String capacity,
    required String type,
    required String price,
    required String description,
  }) {
    emit(AddCourseLoadingState());
    FirebaseFirestore.instance
        .collection('Courses')
        .add({
          'link': link,
          'title': title,
          'location': location,
          'capacity': capacity,
          'description': description,
          'type': type,
          'price': price,
          'image': itemImage,
        })
        .then((value) => {emit(AddCourseSuccessState())})
        .catchError((error) {
          emit(AddCourseErrorState(error.toString()));
        });
  }

  updateCourse({
    required String title,
    required String link,
    required String location,
    required String capacity,
    required String type,
    required String price,
    required String description,
    required String uid,
    required String image,
  }) {
    emit(UpdateCourseLoadingState());
    FirebaseFirestore.instance
        .collection('Courses')
        .doc(uid)
        .update({
          'link': link,
          'title': title,
          'location': location,
          'capacity': capacity,
          'description': description,
          'type': type,
          'price': price,
          'image': itemImage ?? image,
        })
        .then((value) => {emit(UpdateCourseSuccessState())})
        .catchError((error) {
          emit(UpdateCourseErrorState(error.toString()));
        });
  }

  getCourses() {
    emit(GetCourseLoadingState());
    FirebaseFirestore.instance
        .collection('Courses')
        .snapshots()
        .listen((event) {
      coursesList = [];
      for (var element in event.docs) {
        coursesList.add(CourseModel(
          image: element['image'],
          title: element['title'],
          type: element['type'],
          capacity: element['capacity'],
          description: element['description'],
          location: element['location'],
          link: element['link'],
          price: element['price'],
          uid: element.id,
        ));
      }
      emit(GetCourseSuccessState());
    }).onError((error) {
      emit(GetCourseErrorState(error.toString()));
    });
  }

  deleteCourse({required String uidDoc}) {
    emit(DeleteCourseLoadingState());
    FirebaseFirestore.instance
        .collection('Courses')
        .doc(uidDoc)
        .delete()
        .then((value) {
      emit(DeleteCourseSuccessState());
    }).catchError((error) {
      emit(DeleteCourseErrorState(error.toString()));
    });
  }

  addCertificates({
    required String title,
    required String link,
    required String capacity,
    required String price,
    required String description,
  }) {
    emit(AddCertificatesLoadingState());
    FirebaseFirestore.instance
        .collection('Certificates')
        .add({
          'link': link,
          'title': title,
          'capacity': capacity,
          'description': description,
          'price': price,
          'image': itemImage,
        })
        .then((value) => {emit(AddCertificatesSuccessState())})
        .catchError((error) {
          emit(AddCertificatesErrorState(error.toString()));
        });
  }

  updateCertificates({
    required String title,
    required String link,
    required String capacity,
    required String price,
    required String description,
    required String uid,
    required String image,
  }) {
    emit(UpdateCertificatesLoadingState());
    FirebaseFirestore.instance
        .collection('Certificates')
        .doc(uid)
        .update({
          'link': link,
          'title': title,
          'capacity': capacity,
          'description': description,
          'price': price,
          'image': itemImage ?? image,
        })
        .then((value) => {emit(UpdateCertificatesSuccessState())})
        .catchError((error) {
          emit(UpdateCertificatesErrorState(error.toString()));
        });
  }

  getCertificates() {
    emit(GetCertificatesLoadingState());
    FirebaseFirestore.instance
        .collection('Certificates')
        .snapshots()
        .listen((event) {
      certificatesList = [];
      for (var element in event.docs) {
        certificatesList.add(CertificatesModel(
          image: element['image'],
          title: element['title'],
          capacity: element['capacity'],
          description: element['description'],
          link: element['link'],
          price: element['price'],
          uid: element.id,
        ));
      }
      emit(GetCertificatesSuccessState());
    }).onError((error) {
      emit(GetCertificatesErrorState(error.toString()));
    });
  }

  deleteCertificates({required String uidDoc}) {
    emit(DeleteCertificatesLoadingState());
    FirebaseFirestore.instance
        .collection('Certificates')
        .doc(uidDoc)
        .delete()
        .then((value) {
      emit(DeleteCertificatesSuccessState());
    }).catchError((error) {
      emit(DeleteCertificatesErrorState(error.toString()));
    });
  }
}

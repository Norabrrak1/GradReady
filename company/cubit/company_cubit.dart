// ignore_for_file: body_might_complete_normally_catch_error, use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/models/applicants_model.dart';
import 'package:grad_ready/models/company_model.dart';
import 'package:grad_ready/models/post_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../shared/network/local/constant.dart';
//////////////////////////////////////
part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitial());

  static CompanyCubit get(context) => BlocProvider.of(context);
////////////////////////////////////////
  File? itemImageFile;
  String? itemImage;
  File? itemUpdatedImageFile;
  String? itemUpdatedImage;
  CompanyModel? model;
  List<PostModel> trainingPostList = [];
  List<PostModel> volunteerPostList = [];
  List<ApplicantsModel> trainingApplicantsList = [];
  List<ApplicantsModel> volunteerApplicantsList = [];

  getCompanyData() {
    emit(GetCompanyDataLoadingState());
    FirebaseFirestore.instance.collection('company').doc(uId).get().then(
        (value) => {
              model = CompanyModel.fromJson(value.data()!),
              emit(GetCompanyDataSuccessState())
            });
  }

  addCompanyInfo({
    required String name,
    required String field,
    required String about,
    required String mission,
    required String contact,
    required String uid,////
  }) {
    emit(AddCompanyInfoLoadingState());
    FirebaseFirestore.instance
        .collection('company')
        .doc(uid)
        .set({
          'field': field,
          'name': name,
          'uid': uid,
          'mission': mission,
          'about': about,
          'contact': contact,
          'image': itemImage,
        })
        .then((value) => {emit(AddCompanyInfoSuccessState())})
        .catchError((error) {
          emit(AddCompanyInfoErrorState(error.toString()));
        });
  }

  // Start function for upload image
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
      emit(UploadImageSuccessState(itemImage!));
    }).catchError((error) {
      emit(UploadImageErrorState(error.toString()));
    });
  }

// End function for upload image

  addPost({
    required String title,
    required String description,
    required String location,
    required String time,
    required String type,
    required String gpa,
    required String level,
    required String skills,
    required String name,
  }) {
    emit(AddPostLoadingState());
    FirebaseFirestore.instance
        .collection('post')
        .add({
          'title': title,
          'description': description,
          'location': location,
          'type': type,
          'time': time,
          'level': level,
          'gpa': gpa,
          'skills': skills,
          'uidCompany': uId,
          'companyName': name,
          'image': itemImage,
        })
        .then((value) => {emit(AddPostSuccessState())})
        .catchError((error) {
          emit(AddPostErrorState(error.toString()));
        });
  }

  getVolunteerPost() {
    emit(GetVolunteerPostLoadingState());
    FirebaseFirestore.instance
        .collection('post')
        .where('type', isEqualTo: 'Volunteer work')
        .snapshots()
        .listen((event) {/////
      volunteerPostList = [];
      for (var element in event.docs) {
        volunteerPostList.add(PostModel(
          type: element['type'],
          description: element['description'],
          location: element['location'],
          time: element['time'],
          title: element['title'],
          gpa: element['gpa'],
          level: element['level'],
          skills: element['skills'],
          uidCompany: element['uidCompany'],
          image: element['image'],
          companyName: element['companyName'],
          uid: element.id,
        ));
      }
      emit(GetVolunteerPostSuccessState());
    }).onError((error) {
      emit(GetVolunteerPostErrorState(error.toString()));
    });
  }

  getTrainingPost() {
    emit(GetTrainingPostLoadingState());
    FirebaseFirestore.instance
        .collection('post')
        .where('type', isEqualTo: 'Training')
        .snapshots()
        .listen((event) {//event?
      trainingPostList = [];
      for (var element in event.docs) {
        trainingPostList.add(PostModel(
          type: element['type'],
          description: element['description'],
          location: element['location'],
          time: element['time'],
          title: element['title'],
          gpa: element['gpa'],
          level: element['level'],
          skills: element['skills'],
          uidCompany: element['uidCompany'],//////
          image: element['image'],
          companyName: element['companyName'],
          uid: element.id,
        ));
      }
      emit(GetTrainingPostSuccessState());
    }).onError((error) {
      emit(GetTrainingPostErrorState(error.toString()));
    });
  }

  deletePost({required String uidDoc}) {
    emit(DeletePostLoadingState());
    FirebaseFirestore.instance
        .collection('post')
        .doc(uidDoc)
        .delete()
        .then((value) {//////
      emit(DeletePostSuccessState());
    }).catchError((error) {
      emit(DeletePostErrorState(error.toString()));
    });
  }

  editCompanyInfo({
    required String name,
    required String field,
    required String about,
    required String mission,
    required String contact,
    required String uid,
  }) {
    emit(UpdateCompanyInfoLoadingState());
    FirebaseFirestore.instance
        .collection('company')
        .doc(uid)
        .update({
          'field': field,
          'name': name,
          'uid': uid,
          'mission': mission,
          'about': about,
          'contact': contact,
        })
        .then((value) => {emit(UpdateCompanyInfoSuccessState())})
        .catchError((error) {
          emit(UpdateCompanyInfoErrorState(error.toString()));
        });
  }

  updatedShowBottomSheet(BuildContext context) {
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

  Future<void> getUpdatedImage(final file) async {
    if (file != null) {
      itemUpdatedImageFile = File(file.path);
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

  void uploadUpdatedImage() {
    emit(UploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child(
            '/image${Uri.file(itemUpdatedImageFile!.path).pathSegments.last}')
        .putFile(itemUpdatedImageFile!)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      value.ref.getDownloadURL().then((value) {
        itemUpdatedImage = value;
        FirebaseFirestore.instance.collection('company').doc(uId).update({
          'image': itemUpdatedImage,
        });
      }).catchError((error) {
        emit(UploadImageErrorState(error.toString()));
      });
      emit(UploadImageSuccessState(itemUpdatedImage!));
    }).catchError((error) {
      emit(UploadImageErrorState(error.toString()));
    });
  }

  getTrainingApplicants() {
    emit(GetTrainingApplicantsLoadingState());
    FirebaseFirestore.instance
        .collection('applicants')
        .where('uidCompany', isEqualTo: uId)
        .where('type', isEqualTo: 'Training')
        .where('status', isEqualTo: 'Under process')
        .snapshots()
        .listen((event) {
      trainingApplicantsList = [];
      for (var element in event.docs) {
        trainingApplicantsList.add(ApplicantsModel(
          type: element['type'],
          uidUser: element['uidUser'],
          name: element['name'],
          email: element['email'],
          location: element['location'],
          gpa: element['gpa'],
          level: element['level'],
          skills: element['skills'],
          uidCompany: element['uidCompany'],
          status: element['status'],
          uid: element.id,
        ));
      }
      emit(GetTrainingApplicantsSuccessState());
    }).onError((error) {
      emit(GetTrainingApplicantsErrorState(error.toString()));
    });
  }

  getVolunteerApplicants() {
    emit(GetTrainingApplicantsLoadingState());
    FirebaseFirestore.instance
        .collection('applicants')
        .where('uidCompany', isEqualTo: uId)
        .where('type', isEqualTo: 'Volunteer work')
        .where('status', isEqualTo: 'Under process')
        .snapshots()
        .listen((event) {
      volunteerApplicantsList = [];
      for (var element in event.docs) {
        volunteerApplicantsList.add(ApplicantsModel(
          type: element['type'],
          uidUser: element['uidUser'],
          name: element['name'],
          email: element['email'],
          location: element['location'],
          gpa: element['gpa'],
          level: element['level'],
          skills: element['skills'],
          uidCompany: element['uidCompany'],
          status: element['status'],
          uid: element.id,
        ));
      }
      emit(GetTrainingApplicantsSuccessState());
    }).onError((error) {
      emit(GetTrainingApplicantsErrorState(error.toString()));
    });
  }

  acceptApplicants({required String uidDoc}) {
    emit(AcceptApplicantsLoadingState());
    FirebaseFirestore.instance
        .collection('applicants')
        .doc(uidDoc)
        .update({'status': 'Accepted'}).then((value) {
      emit(AcceptApplicantsSuccessState());
    }).catchError((error) {
      emit(AcceptApplicantsErrorState(error.toString()));
    });
  }

  rejectApplicants({required String uidDoc}) {
    emit(RejectApplicantsLoadingState());
    FirebaseFirestore.instance
        .collection('applicants')
        .doc(uidDoc)
        .update({'status': 'Rejected'}).then((value) {
      emit(RejectApplicantsSuccessState());
    }).catchError((error) {
      emit(RejectApplicantsErrorState(error.toString()));
    });
  }
}

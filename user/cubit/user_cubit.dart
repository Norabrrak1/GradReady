// ignore_for_file: body_might_complete_normally_catch_error, use_build_context_synchronously
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/models/post_model.dart';
import 'package:grad_ready/models/user_model.dart';
import 'package:grad_ready/models/user_profile_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/applicants_model.dart';
import '../../../models/certificates_model.dart';
import '../../../models/course_model.dart';
import '../../../shared/network/local/constant.dart';
import '../request/view.dart';
import '../user_home/view.dart';
import '../user_profile/view.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  List<PostModel> trainingPostList = [];
  List<PostModel> filterList = [];
  List<PostModel> volunteerPostList = [];
  List<EducationModel> educationList = [];
  List<CourseModel> coursesList = [];
  List<CertificatesModel> certificatesList = [];
  UserModel? model;
  UserProfileModel? userProfileModel;
  File? itemImageFile;
  String? itemImage;
  List<ApplicantsModel> trainingApplicantsList = [];

  int pageIndex = 1;

  List page = [
    const RequestScreen(),
    const UserHomeScreen(),
    const UserProfileScreen(),
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      getUserProfile();
    }
    if (index == 0) {
      getApplicants();
    }
    if (index == 1) {
      getTrainingPost();
      getVolunteersPost();
      getCourses();
      getCertificates();
    }
    Timer(const Duration(milliseconds: 15), () {
      pageIndex = index;
    });
    emit(ChangeBottomStaffNavState());
  }

  getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
        (value) => {
              model = UserModel.fromJson(value.data()!),
              emit(GetUserDataSuccessState())
            });
  }

  addUserInfo({
    required String name,
    required String birth,
    required String gender,
    required String phone,
    required String location,
    required List skills,
    required List interests,
    required List language,
  }) {
    emit(AddUserInfoLoadingState());
    FirebaseFirestore.instance.collection('usersProfile').doc(uId).set({
      'gender': gender,
      'birth': birth,
      'name': name,
      'email': model!.email!,
      'phone': phone,
      'language': language,
      'interests': interests,
      'image': itemImage,
      'location': location,
      'uid': uId,
      'skills': skills,
    }).then((value) => {emit(AddUserInfoSuccessState())});
  }

  updateUserInfo({
    required String name,
    required String birth,
    required String gender,
    required String phone,
    required String location,
    required List skills,
    required List interests,
    required List language,
    required String image,
  }) {
    emit(UpdateUserInfoLoadingState());
    FirebaseFirestore.instance.collection('usersProfile').doc(uId).set({
      'gender': gender,
      'birth': birth,
      'name': name,
      'email': model!.email!,
      'phone': phone,
      'language': language,
      'interests': interests,
      'image': itemImage ?? image,
      'location': location,
      'uid': uId,
      'skills': skills,
    }).then((value) => {emit(UpdateUserInfoSuccessState())});
  }

  getTrainingPost() {
    emit(GetTrainingPostLoadingState());
    FirebaseFirestore.instance
        .collection('post')
        .where('type', isEqualTo: 'Training')
        .snapshots()
        .listen((event) {
      trainingPostList = [];
      for (var element in event.docs) {
        trainingPostList.add(PostModel(
            type: element['type'],
            description: element['description'],
            location: element['location'],
            start: element['start'],
            end: element['end'],
            title: element['title'],
            gpa: element['gpa'],
            level: element['level'],
            skills: element['skills'],
            uidCompany: element['uidCompany'],
            image: element['image'],
            companyName: element['companyName'],
            uid: element.id,
            status: element['status']));
      }
      emit(GetTrainingPostSuccessState());
    }).onError((error) {
      emit(GetTrainingPostErrorState(error.toString()));
    });
  }

  getVolunteersPost() {
    emit(GetVolunteersPostLoadingState());
    FirebaseFirestore.instance
        .collection('post')
        .where('type', isEqualTo: 'Volunteer work')
        .snapshots()
        .listen((event) {
      volunteerPostList = [];
      for (var element in event.docs) {
        volunteerPostList.add(PostModel(
            type: element['type'],
            description: element['description'],
            location: element['location'],
            start: element['start'],
            end: element['end'],
            title: element['title'],
            gpa: element['gpa'],
            level: element['level'],
            skills: element['skills'],
            uidCompany: element['uidCompany'],
            image: element['image'],
            companyName: element['companyName'],
            uid: element.id,
            status: element['status']));
      }
      emit(GetVolunteersPostSuccessState());
    }).onError((error) {
      emit(GetVolunteersPostErrorState(error.toString()));
    });
  }

  submitApplication({
    required String location,
    required String email,
    required String gpa,
    required String level,
    required String type,
    required String skills,
    required String name,
    required String uidCompany,
    required String uidUser,
    required String image,
    required String description,
    required String start,
    required String end,
    required String title,
    required String display,
  }) {
    emit(SubmitApplicationLoadingState());
    FirebaseFirestore.instance
        .collection('applicants')
        .add({
          'location': location,
          'email': email,
          'level': level,
          'gpa': gpa,
          'skills': skills,
          'uidCompany': uidCompany,
          'uidUser': uidUser,
          'name': name,
          'type': type,
          'image': image,
          'description': description,
          'start': start,
          'end': end,
          'title': title,
          'status': 'Under process',
          'display': display,
        })
        .then((value) => {emit(SubmitApplicationSuccessState())})
        .catchError((error) {
          emit(SubmitApplicationErrorState(error.toString()));
        });
  }

  getUserProfile() {
    emit(GetUserProfileDataLoadingState());
    FirebaseFirestore.instance
        .collection('usersProfile')
        .doc(uId)
        .get()
        .then((value) => {
              userProfileModel = UserProfileModel(
                name: value['name'],
                image: value['image'],
                email: value['email'],
                skills: value['skills'],
                language: value['language'],
                birth: value['birth'],
                gender: value['gender'],
                interests: value['interests'],
                location: value['location'],
                phone: value['phone'],
                uid: value['uid'],
              ),
              getEducation(),
              emit(GetUserProfileDataSuccessState())
            })
        .catchError((error) {
      emit(GetUserProfileDataErrorState(error.toString()));
    });
  }

  getEducation() {
    emit(GetEducationLoadingState());
    FirebaseFirestore.instance
        .collection('usersProfile')
        .doc(uId)
        .collection('education')
        .snapshots()
        .listen((event) {
      educationList = [];
      for (var element in event.docs) {
        educationList.add(EducationModel(
          uidUser: element['uidUser'],
          end: element['end'],
          major: element['major'],
          numYears: element['numYears'],
          start: element['start'],
          university: element['university'],
          uid: element.id,
        ));
      }
      emit(GetEducationSuccessState());
    }).onError((error) {
      emit(GetEducationErrorState(error.toString()));
    });
  }

  addEducation({
    required String major,
    required String university,
    required String start,
    required String end,
    required String numYears,
  }) {
    emit(AddEducationLoadingState());
    FirebaseFirestore.instance
        .collection('usersProfile')
        .doc(uId)
        .collection('education')
        .add({
          'major': major,
          'numYears': numYears,
          'university': university,
          'end': end,
          'start': start,
          'uidUser': uId,
        })
        .then((value) => {emit(AddEducationSuccessState())})
        .catchError((error) {
          emit(AddEducationErrorState(error.toString()));
        });
  }

  editEducation({
    required String major,
    required String university,
    required String start,
    required String end,
    required String numYears,
    required String id,
  }) {
    emit(UpdateEducationLoadingState());
    FirebaseFirestore.instance
        .collection('usersProfile')
        .doc(uId)
        .collection('education')
        .doc(id)
        .update({
          'major': major,
          'numYears': numYears,
          'university': university,
          'end': end,
          'start': start,
          'uidUser': uId,
        })
        .then((value) => {emit(UpdateEducationSuccessState())})
        .catchError((error) {
          emit(UpdateEducationErrorState(error.toString()));
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
      emit(UploadImageSuccessState());
    }).catchError((error) {
      emit(UploadImageErrorState(error.toString()));
    });
  }

// End function for upload image

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

  getApplicants() {
    emit(GetApplicantsLoadingState());
    FirebaseFirestore.instance
        .collection('applicants')
        .where('uidUser', isEqualTo: uId)
        .snapshots()
        .listen((event) {
      trainingApplicantsList = [];
      for (var element in event.docs) {
        trainingApplicantsList.add(ApplicantsModel(
          description: element['description'],
          start: element['start'],
          end: element['end'],
          image: element['image'],
          title: element['title'],
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
      emit(GetApplicantsSuccessState());
    }).onError((error) {
      emit(GetApplicantsErrorState(error.toString()));
    });
  }

  getFilter({
    required String category,
    required String location,
    required String status,
  }) {
    emit(GetFilterLoadingState());
    if (category == 'Training Activities') {
      FirebaseFirestore.instance
          .collection('post')
          .where('type', isEqualTo: 'Training')
          .where('location', isEqualTo: location)
          .where('status', isEqualTo: status)
          .snapshots()
          .listen((event) {
        filterList = [];
        for (var element in event.docs) {
          filterList.add(PostModel(
              type: element['type'],
              description: element['description'],
              location: element['location'],
              start: element['start'],
              end: element['end'],
              title: element['title'],
              gpa: element['gpa'],
              level: element['level'],
              skills: element['skills'],
              uidCompany: element['uidCompany'],
              image: element['image'],
              companyName: element['companyName'],
              uid: element.id,
              status: element['status']));
        }
        print(filterList.length);
        emit(GetFilterSuccessState());
      }).onError((error) {
        emit(GetFilterErrorState(error.toString()));
      });
    } else if (category == 'Volunteers Activity') {
      emit(GetFilterLoadingState());
      FirebaseFirestore.instance
          .collection('post')
          .where('type', isEqualTo: 'Volunteer work')
          .where('location', isEqualTo: location)
          .where('status', isEqualTo: status)
          .snapshots()
          .listen((event) {
        filterList = [];
        for (var element in event.docs) {
          filterList.add(PostModel(
              type: element['type'],
              description: element['description'],
              location: element['location'],
              start: element['start'],
              end: element['end'],
              title: element['title'],
              gpa: element['gpa'],
              level: element['level'],
              skills: element['skills'],
              uidCompany: element['uidCompany'],
              image: element['image'],
              companyName: element['companyName'],
              uid: element.id,
              status: element['status']));
        }
        emit(GetFilterSuccessState());
      }).onError((error) {
        emit(GetFilterErrorState(error.toString()));
      });
    }
  }
}

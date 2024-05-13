import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/admin/manage_courses/view.dart';
import 'package:grad_ready/models/course_model.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../cubit/admin_cubit.dart';

class EditCourseScreen extends StatefulWidget {
  final CourseModel model;

  const EditCourseScreen({required this.model, super.key});

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String? typeCourse;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.model.title);
    descriptionController =
        TextEditingController(text: widget.model.description);
    priceController = TextEditingController(text: widget.model.price);
    capacityController = TextEditingController(text: widget.model.capacity);
    linkController = TextEditingController(text: widget.model.link);
    locationController = TextEditingController(text: widget.model.location);
    typeCourse = widget.model.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is UpdateCourseSuccessState) {
          showToast(
              text: 'edit course successfully', state: ToastStates.success);
          Timer(const Duration(seconds: 1), () {
            navigateTo(context, const ManageCoursesScreen());
          });
        }
        if (state is UploadImageSuccessState) {
          showToast(text: 'add image successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Course',
              ),
              leading:
              IconButton(onPressed: () {
                navigateTo(context, const ManageCoursesScreen());
              }, icon: const Icon(Icons.arrow_back)),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldTemplate(
                      labelText: 'Title',
                      hintText: 'enter title of course',
                      keyType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter enter title of course';
                        }
                      },
                      controller: titleController,
                    ),
                    TextFieldTemplate(
                      labelText: 'Link',
                      hintText: 'enter link of course',
                      keyType: TextInputType.text,
                      controller: linkController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter link of course';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      labelText: 'Capacity',
                      hintText: 'enter capacity of course',
                      keyType: TextInputType.text,
                      controller: capacityController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter capacity of course';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      labelText: 'Price',
                      hintText: 'enter price of course',
                      keyType: TextInputType.text,
                      controller: priceController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter price of course';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      labelText: 'Location',
                      hintText: 'enter capacity of location',
                      keyType: TextInputType.text,
                      controller: locationController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter location of course';
                        }
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('Type Post : ',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  color: AppColors.blue2,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Container(
                          width: width(context, 1.16),
                          height: 60,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: AppColors.grey,
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, blurRadius: 2)
                              ]),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: typeCourse,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    typeCourse = newValue!;
                                  });
                                },
                                items: <String>[
                                  'online',
                                  'offline '
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFieldTemplate(
                      labelText: 'Description',
                      hintText: 'enter description',
                      lines: 5,
                      keyType: TextInputType.text,
                      controller: descriptionController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter description of course';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //upload image button
                    state is UploadImageLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonTemplate(
                            color: AppColors.blue2,
                            text1: 'Upload image',
                            onPressed: () {
                              AdminCubit.get(context).showBottomSheet(context);
                            },
                            width: width(context, 2),
                            height: 50,
                            textStyle:
                                AppTextStyles.button.copyWith(fontSize: 16),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    state is UpdateCourseLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonTemplate(
                            color: AppColors.blue,
                            text1: 'Send',
                            onPressed: () {
                              if (typeCourse == null) {
                                showToast(
                                    text: 'please , choose course type',
                                    state: ToastStates.error);
                              }
                              if (formKey.currentState!.validate()) {
                                AdminCubit.get(context).updateCourse(
                                    uid: widget.model.uid!,
                                    image: widget.model.image!,
                                    title: titleController.text,
                                    link: linkController.text,
                                    location: locationController.text,
                                    capacity: capacityController.text,
                                    type: typeCourse!,
                                    price: priceController.text,
                                    description: descriptionController.text);
                              }
                            },
                            textStyle:
                                AppTextStyles.button.copyWith(fontSize: 16),
                            height: 50,
                            width: width(context, 1.5),
                          ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

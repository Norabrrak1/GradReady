import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/company/company_home/view.dart';
import 'package:grad_ready/features/company/cubit/company_cubit.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import '../../../shared/components/components.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final timeController = TextEditingController();
  final postTypeController = TextEditingController();
  final gpaController = TextEditingController();
  final levelDevelopmentController = TextEditingController();
  final programmingSkillsController = TextEditingController();
  String? typePost;
  String? gpaNumber;
  List<String> gpa = [
    '1.0',
    '1.3',
    '1.7',
    '2.0',
    '2.3',
    '2.7',
    '3.0',
    '3.3',
    '3.7',
    '4.0',
  ];
  String? level;
  List<String> levelList = [
    'Basic',
    'Medium',
    'Advance',
  ];
  String? skills;
  List<String> skillsList = [
    'Java',
    'Python',
    'JavaScript',
  ];
  TimeOfDay selectedTime = TimeOfDay.now();
  String? time;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
        time = selectedTime.format(context);
        timeController.text = time!;
        if (kDebugMode) {
          print(selectedTime);
          print(time);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        if (state is AddPostSuccessState) {
          showToast(text: 'Add post successfully', state: ToastStates.success);
          navigateTo(context, const CompanyHomeScreen());
        }
        if (state is UploadImageSuccessState) {
          showToast(text: 'Upload image successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigateTo(context, const CompanyHomeScreen());
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    'Post',
                    style: AppTextStyles.boldTitles2,
                  )),
                  TextFieldTemplate(
                    hintText: '',
                    keyType: TextInputType.name,
                    controller: titleController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter title of post ';
                      }
                    },
                    labelText: 'Title : ',
                  ),
                  TextFieldTemplate(
                    hintText: '',
                    keyType: TextInputType.name,
                    controller: descriptionController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter description of post ';
                      }
                    },
                    labelText: 'Description : ',
                  ),
                  TextFieldTemplate(
                    hintText: '',
                    keyType: TextInputType.name,
                    controller: locationController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter location of company ';
                      }
                    },
                    labelText: 'Location : ',
                  ),
                  TextFieldClicked(
                    hintText: '',
                    onTap: () {
                      _selectTime(context);
                    },
                    controller: timeController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter time for the post ';
                      }
                    },
                    labelText: 'Time : ',
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Column(
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
                        ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  hintStyle: const TextStyle(
                                    color: AppColors.purple,
                                    fontSize: 14,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: AppColors.grey,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.grey, width: 1.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.grey, width: 1.5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.grey, width: 1.5),
                                  )),
                              isExpanded: true,
                              value: typePost,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select Type Post';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (String? newValue) {
                                setState(() {
                                  typePost = newValue!;
                                });
                              },
                              items: <String>[
                                'Training',
                                'Volunteer work'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Header(
                    text: 'Requirement :',
                    style: GoogleFonts.dmSans(
                        fontSize: 16,
                        color: AppColors.blue2,
                        fontWeight: FontWeight.w600),
                    alignment: Alignment.centerLeft,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        text: 'GPA :',
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            color: AppColors.blue2,
                            fontWeight: FontWeight.w600),
                        alignment: Alignment.centerLeft,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 5),
                        child: SizedBox(
                          width: width(context, 3),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.white,
                                    hintStyle: const TextStyle(
                                      color: AppColors.purple,
                                      fontSize: 14,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: AppColors.grey,
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    )),
                                value: gpaNumber,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select GPA';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (String? newValue) {
                                  setState(() {
                                    gpaNumber = newValue!;
                                  });
                                },
                                items: gpa.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        text: 'Level of \nDevelopment :',
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            color: AppColors.blue2,
                            fontWeight: FontWeight.w600),
                        alignment: Alignment.centerLeft,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 5),
                        child: SizedBox(
                          width: width(context, 3),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.white,
                                    hintStyle: const TextStyle(
                                      color: AppColors.purple,
                                      fontSize: 14,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: AppColors.grey,
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    )),
                                value: level,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select Level of Development';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (String? newValue) {
                                  setState(() {
                                    level = newValue!;
                                  });
                                },
                                items: levelList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header(
                        text: 'Programming skills :',
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            color: AppColors.blue2,
                            fontWeight: FontWeight.w600),
                        alignment: Alignment.centerLeft,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: SizedBox(
                          width: width(context, 3),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.white,
                                    hintStyle: const TextStyle(
                                      color: AppColors.purple,
                                      fontSize: 14,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: AppColors.grey,
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                    )),
                                isExpanded: true,
                                value: skills,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select skill';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (String? newValue) {
                                  setState(() {
                                    skills = newValue!;
                                  });
                                },
                                items: skillsList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is UploadImageLoadingState
                      ? const CircularProgressIndicator()
                      : ButtonTemplate(
                      height: 50,
                      width: width(context, 2),
                      color: AppColors.purple,
                      text1: 'UPLOAD PHOTO ',
                      onPressed: () {
                        CompanyCubit.get(context).showBottomSheet(context);
                      },
                      textStyle: AppTextStyles.button.copyWith(fontSize: 16)),
                  const SizedBox(
                    height: 20,
                  ),
                  state is AddPostLoadingState
                      ? const CircularProgressIndicator()
                      : ButtonTemplate(
                          height: 50,
                          width: width(context, 1.5),
                          color: AppColors.blue,
                          text1: 'Submit APPLICATION',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              CompanyCubit.get(context).addPost(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  location: locationController.text,
                                  time: timeController.text,
                                  name: CompanyCubit.get(context).model!.name!,//////
                                  type: typePost!,
                                  gpa: gpaNumber!,
                                  level: level!,
                                  skills: skills!);
                            }
                          },
                          textStyle:
                              AppTextStyles.button.copyWith(fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

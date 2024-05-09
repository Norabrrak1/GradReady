// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/models/user_profile_model.dart';
import 'package:intl/intl.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';
import 'constants.dart';
import 'navigator.dart';

class ButtonTemplate extends StatelessWidget {
  ButtonTemplate({
    super.key,
    required this.color,
    required this.text1,
    required this.onPressed,
    this.width,
    this.height,
    required this.textStyle,
  });

  Color color;
  String text1;
  double? width;
  double? height;
  TextStyle? textStyle;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: MaterialButton(
        minWidth: width,
        height: height,
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(text1, style: textStyle),
      ),
    );
  }
}

class TextFieldTemplate extends StatelessWidget {
  TextFieldTemplate(
      {super.key,
      required this.hintText,
      required this.labelText,
      this.controller,
      this.obscureText = false,
      this.readOnly = false,
      this.validator,
      this.keyType,
      this.lines});

  String hintText;
  String labelText;
  TextEditingController? controller;
  bool obscureText;
  Function? validator;
  int? lines;
  TextInputType? keyType;
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(labelText,
                style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: AppColors.blue2,
                    fontWeight: FontWeight.w600)),
          ),
          Material(
            elevation: 5,
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
            child: TextFormField(
              obscureText: obscureText,
              maxLines: lines,
              controller: controller,
              validator: (value) => validator!(value),
              keyboardType: keyType,
              readOnly: readOnly,
              decoration: InputDecoration(
                  hintText: hintText,
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
                    borderSide:
                        const BorderSide(color: AppColors.grey, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: AppColors.grey, width: 1.5),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: AppColors.grey, width: 1.5),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}


class SearchTextField extends StatelessWidget {
  final String? text;
  final TextEditingController? controller;

  const SearchTextField({
    super.key,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width(context, 1.3),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: text,
            hintStyle: AppTextStyles.hintStyle
                .copyWith(color: AppColors.grey3, height: 1),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.grey3,
            ),
            fillColor: AppColors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grey, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grey, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.grey, width: 1.5),
            )),
      ),
    );
  }
}


showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

//enum (if there many choices)
enum ToastStates { success, error, warning }

Color? chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}


class TextFieldClicked extends StatelessWidget {
  final String? hintText;
  final String labelText;
  final String? txt;
  Function? validator;
  void Function()? onTap;
  final TextEditingController? controller;

  // ignore: use_key_in_widget_constructors
  TextFieldClicked(
      {this.hintText,
      required this.labelText,
      this.onTap,
      this.controller,
      this.validator,
      initialValue,
      this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(labelText,
                style: GoogleFonts.dmSans(
                    fontSize: 16,
                    color: AppColors.blue2,
                    fontWeight: FontWeight.w600)),
          ),
          Material(
            elevation: 5,
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
            child: TextFormField(
              initialValue: txt,
              onTap: onTap,
              validator: (value) => validator!(value),
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                  hintText: hintText,
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
                    borderSide:
                        const BorderSide(color: AppColors.grey, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: AppColors.grey, width: 1.5),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: AppColors.grey, width: 1.5),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String? text;
  TextStyle? style;
  AlignmentGeometry? alignment;

  Header({this.text, this.style, this.alignment, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Align(
          alignment: alignment!,
          child: Text(
            text!,
            style: style,
            maxLines: 2,
          ),
        ));
  }
}



showDialogWarning(
  BuildContext context, {
  required String text,
  required Function onTap,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.blue, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: Container(
            width: width(context, 1),
            height: height(context, 10),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                text,
                style: AppTextStyles.labelStyle,
              ),
            )),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                navigatePop(context);
              },
              child: Text(
                'Cancel',
                style: AppTextStyles.hintStyle
                    .copyWith(color: Colors.red, fontSize: 20),
              )),
          TextButton(
              onPressed: () => onTap(),
              child: Text(
                'Ok',
                style: AppTextStyles.hintStyle
                    .copyWith(color: AppColors.blue2, fontSize: 20),
              ))
        ],
      );
    },
  );
}

addEducationDialog(BuildContext context, {required UserState state}) {
  final formKey = GlobalKey<FormState>();
  TextEditingController major = TextEditingController();
  TextEditingController university = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController numYears = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is AddEducationSuccessState) {
            showToast(text: 'add successfully', state: ToastStates.success);
            UserCubit.get(context).getEducation();
            navigatePop(context);
          }
        },
        builder: (context, state) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                insetPadding: const EdgeInsets.symmetric(vertical: 10),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                title: Center(
                    child: Text(
                  'Add Education',
                  style: AppTextStyles.title.copyWith(fontSize: 20),
                )),
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.blue, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                content: SizedBox(
                  width: width(context, 1.1),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFieldTemplate(
                            hintText: '',
                            keyType: TextInputType.name,
                            controller: major,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter major';
                              }
                            },
                            labelText: 'Major',
                          ),
                          TextFieldTemplate(
                            hintText: '',
                            keyType: TextInputType.name,
                            controller: university,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter university';
                              }
                            },
                            labelText: 'University',
                          ),
                          TextFieldClicked(
                            labelText: 'Start',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter start date';
                              }
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime(2025));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  startDate.text = formattedDate;
                                });
                              } else {
                                if (kDebugMode) {
                                  print("Date is not selected");
                                }
                              }
                            },
                            controller: startDate,
                          ),
                          TextFieldClicked(
                            labelText: 'End',
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime(2025));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  endDate.text = formattedDate;
                                });
                              } else {
                                if (kDebugMode) {
                                  print("Date is not selected");
                                }
                              }
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter start date';
                              }
                            },
                            controller: endDate,
                          ),
                          TextFieldTemplate(
                            hintText: '',
                            keyType: TextInputType.name,
                            controller: numYears,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter numYears';
                              }
                            },
                            labelText: 'Number of Years',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  state is AddEducationLoadingState
                      ? const CircularProgressIndicator()
                      : Center(
                          child: ButtonTemplate(
                              height: 50,
                              width: width(context, 2),
                              color: AppColors.blue,
                              text1: ' ADD',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  UserCubit.get(context).addEducation(
                                      major: major.text,
                                      university: university.text,
                                      start: startDate.text,
                                      end: endDate.text,
                                      numYears: numYears.text);
                                }
                              },
                              textStyle:
                                  AppTextStyles.button.copyWith(fontSize: 16)),
                        ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

editEducationDialog(BuildContext context,
    {required UserState state, required EducationModel model}) {
  final formKey = GlobalKey<FormState>();
  TextEditingController major = TextEditingController(text: model.major);
  TextEditingController university =
      TextEditingController(text: model.university);
  TextEditingController startDate = TextEditingController(text: model.start);
  TextEditingController endDate = TextEditingController(text: model.end);
  TextEditingController numYears = TextEditingController(text: model.numYears);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateEducationSuccessState) {
            showToast(text: 'edit successfully', state: ToastStates.success);
            UserCubit.get(context).getEducation();
            navigatePop(context);
          }
        },
        builder: (context, state) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                insetPadding: const EdgeInsets.symmetric(vertical: 10),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                title: Center(
                    child: Text(
                  'Edit Education',
                  style: AppTextStyles.title.copyWith(fontSize: 20),
                )),
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.blue, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                content: SizedBox(
                  width: width(context, 1.1),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFieldTemplate(
                            hintText: '',
                            keyType: TextInputType.name,
                            controller: major,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter major';
                              }
                            },
                            labelText: 'Major',
                          ),
                          TextFieldTemplate(
                            hintText: '',
                            keyType: TextInputType.name,
                            controller: university,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter university';
                              }
                            },
                            labelText: 'University',
                          ),
                          TextFieldClicked(
                            labelText: 'Start',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter start date';
                              }
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime(2025));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  startDate.text = formattedDate;
                                });
                              } else {
                                if (kDebugMode) {
                                  print("Date is not selected");
                                }
                              }
                            },
                            controller: startDate,
                          ),
                          TextFieldClicked(
                            labelText: 'End',
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime(2025));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  endDate.text = formattedDate;
                                });
                              } else {
                                if (kDebugMode) {
                                  print("Date is not selected");
                                }
                              }
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter start date';
                              }
                            },
                            controller: endDate,
                          ),
                          TextFieldTemplate(
                            hintText: '',
                            keyType: TextInputType.name,
                            controller: numYears,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter numYears';
                              }
                            },
                            labelText: 'Number of Years',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  state is AddEducationLoadingState
                      ? const CircularProgressIndicator()
                      : Center(
                          child: ButtonTemplate(
                              height: 50,
                              width: width(context, 2),
                              color: AppColors.blue,
                              text1: ' EDIT',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  UserCubit.get(context).editEducation(
                                      major: major.text,
                                      university: university.text,
                                      start: startDate.text,
                                      end: endDate.text,
                                      numYears: numYears.text,
                                      id: model.uid!);
                                }
                              },
                              textStyle:
                                  AppTextStyles.button.copyWith(fontSize: 16)),
                        ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

class Box extends StatelessWidget {
  String? text;
  String? image;

  void Function()? onTap;

  Box(
      {required this.text,
      required this.image,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context, 2.5),
      height: height(context, 3.5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.litePink,
              child: ImageIcon(
                  color: AppColors.orange,
                  size: 30,
                  AssetImage(
                    image!,
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              text!,
              style: AppTextStyles.button
                  .copyWith(color: AppColors.blue2, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Option extends StatefulWidget {
  final String title;
  final List list;

  const Option({required this.title, required this.list, super.key});

  @override
  State<Option> createState() => _OptionState();
}

bool isChecked = false;

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          if (isChecked == true) {
            widget.list.add(widget.title);
          } else {
            widget.list.remove(widget.title);
          }
          if (kDebugMode) {
            print(isChecked);
            print(widget.list);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isChecked ? AppColors.blue3 : AppColors.grey,
            border: Border.all(
              color: isChecked ? AppColors.blue4 : AppColors.grey,
            )),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: AppTextStyles.hintStyle.copyWith(
            color: AppColors.blue,
          ),
        ),
      ),
    );
  }
}

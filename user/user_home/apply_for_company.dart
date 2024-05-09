import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import '../../../models/post_model.dart';
import '../../../shared/components/navigator.dart';
import '../navigation_screen/view.dart';

class ApplyScreen extends StatefulWidget {
  final PostModel? model;

  const ApplyScreen({required this.model, super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final formKey = GlobalKey<FormState>();
  String? levelDevelopment;
  String? programmingSkills;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gpaController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String? gpaNumber;
  String? display;
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SubmitApplicationSuccessState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: const EdgeInsets.symmetric(vertical: 10),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.blue, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                content: SizedBox(
                  width: width(context, 1.1),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Image(
                            image:
                                AssetImage('assets/images/illustration.png')),
                        Text(
                          'Successful',
                          style: AppTextStyles.name,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Congratulations, your application has been sent',
                          style: AppTextStyles.title.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: ButtonTemplate(
                        height: 50,
                        width: width(context, 2),
                        color: AppColors.blue,
                        text1: 'BACK TO HOME',
                        onPressed: () {
                          navigateTo(context, const UserNavigation());
                        },
                        textStyle: AppTextStyles.button.copyWith(fontSize: 16)),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Apply',
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Header(
                    text: 'Level of Development',
                    style: GoogleFonts.dmSans(
                        fontSize: 18,
                        color: AppColors.blue2,
                        fontWeight: FontWeight.w600),
                    alignment: Alignment.centerLeft,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Basic',
                              groupValue: levelDevelopment,
                              activeColor: AppColors.grey2,
                              fillColor:
                                  MaterialStateProperty.all(AppColors.orange),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  levelDevelopment = value;
                                });
                              },
                            ),
                            Text(
                              'Basic',
                              style: AppTextStyles.smTitles,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Medium',
                              groupValue: levelDevelopment,
                              activeColor: AppColors.grey2,
                              fillColor:
                                  MaterialStateProperty.all(AppColors.orange),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  levelDevelopment = value;
                                });
                              },
                            ),
                            Text(
                              'Medium',
                              style: AppTextStyles.smTitles,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Advance',
                              groupValue: levelDevelopment,
                              activeColor: AppColors.grey2,
                              fillColor:
                                  MaterialStateProperty.all(AppColors.orange),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  levelDevelopment = value;
                                });
                              },
                            ),
                            Text(
                              'Advance',
                              style: AppTextStyles.smTitles,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Header(
                    text: 'Programming skills',
                    style: GoogleFonts.dmSans(
                        fontSize: 18,
                        color: AppColors.blue2,
                        fontWeight: FontWeight.w600),
                    alignment: Alignment.centerLeft,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Java',
                              groupValue: programmingSkills,
                              activeColor: AppColors.grey2,
                              fillColor:
                                  MaterialStateProperty.all(AppColors.orange),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  programmingSkills = value;
                                });
                              },
                            ),
                            Text(
                              'Java',
                              style: AppTextStyles.smTitles,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Python',
                              groupValue: programmingSkills,
                              activeColor: AppColors.grey2,
                              fillColor:
                                  MaterialStateProperty.all(AppColors.orange),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  programmingSkills = value;
                                });
                              },
                            ),
                            Text(
                              'Python',
                              style: AppTextStyles.smTitles,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'JavaScript',
                              groupValue: programmingSkills,
                              activeColor: AppColors.grey2,
                              fillColor:
                                  MaterialStateProperty.all(AppColors.orange),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  programmingSkills = value;
                                });
                              },
                            ),
                            Text(
                              'Javascript',
                              style: AppTextStyles.smTitles,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
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
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                  ),
                  TextFieldTemplate(
                    hintText: '',
                    keyType: TextInputType.text,
                    controller: locationController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter location';
                      }
                    },
                    labelText: 'Location',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is SubmitApplicationLoadingState
                      ? const CircularProgressIndicator()
                      : ButtonTemplate(
                          height: 50,
                          width: width(context, 1.5),
                          color: AppColors.blue,
                          text1: 'SUBMIT  APPLICATION',
                          onPressed: () {
                            if (levelDevelopment == null) {
                              showToast(
                                  text: 'Choose the level of development ',
                                  state: ToastStates.error);
                            } else if (programmingSkills == null) {
                              showToast(
                                  text: 'Choose the programming skills ',
                                  state: ToastStates.error);
                            } else if (formKey.currentState!.validate()) {
                              print(widget.model!.gpa!);
                              print(gpaNumber);
                              print(widget.model!.level!);
                              print(levelDevelopment);
                              print(widget.model!.skills!);
                              print(programmingSkills);
                              double targetGPA =
                                  double.parse(widget.model!.gpa!);
                              double selectedGPA = double.parse(gpaNumber!);
                              print(targetGPA);
                              print(selectedGPA);
                              if (selectedGPA >= targetGPA) {
                                print('true');
                              } else {
                                print('false');
                              }
                              if (selectedGPA >= targetGPA &&
                                  widget.model!.level! == levelDevelopment &&
                                  widget.model!.skills! == programmingSkills) {
                                display = 'allow';
                              } else {
                                display = 'notAllow';
                              }
                              print(display!);
                              UserCubit.get(context).submitApplication(
                                  type: widget.model!.type!,
                                  title: widget.model!.title!,
                                  start: widget.model!.start!,
                                  end: widget.model!.end!,
                                  image: widget.model!.image!,
                                  description: widget.model!.description!,
                                  uidUser: UserCubit.get(context).model!.uid!,
                                  location: locationController.text,
                                  email: UserCubit.get(context).model!.email!,
                                  gpa: gpaNumber!,
                                  level: levelDevelopment!,
                                  skills: programmingSkills!,
                                  name: UserCubit.get(context).model!.name!,
                                  display: display!,
                                  uidCompany: widget.model!.uidCompany!);
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

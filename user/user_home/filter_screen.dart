import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/features/user/navigation_screen/view.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

import 'filter_result.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

String? location;
List<String> locationList = [
  'Jeddah',
  'Riyadh',
  'Taif',
];
String? category;
String? status;
String? workPlace;
TextEditingController locationController = TextEditingController();

class _FilterScreenState extends State<FilterScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetFilterSuccessState) {
          navigateTo(context, const FilterResultScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  navigateTo(context, UserNavigation());
                }),
            title: const Text(
              'Filter',
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Header(
                    text: 'Category ',
                    style: GoogleFonts.dmSans(
                        fontSize: 18,
                        color: AppColors.blue2,
                        fontWeight: FontWeight.w600),
                    alignment: Alignment.centerLeft,
                  ),
                  ListTile(
                    title: const Text('Training Activities'),
                    leading: Radio<String>(
                      value: 'Training Activities',
                      groupValue: category,
                      activeColor: AppColors.grey2,
                      fillColor: MaterialStateProperty.all(AppColors.orange),
                      splashRadius: 20,
                      onChanged: (value) {
                        setState(() {
                          category = value;
                          // print(category!);
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Volunteers Activity'),
                    leading: Radio<String>(
                      value: 'Volunteers Activity',
                      groupValue: category,
                      activeColor: AppColors.grey2,
                      fillColor: MaterialStateProperty.all(AppColors.orange),
                      splashRadius: 20,
                      onChanged: (value) {
                        setState(() {
                          category = value;
                          // print(category!);
                        });
                      },
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('Location ',
                            style: GoogleFonts.dmSans(
                                fontSize: 18,
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
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: location,
                              onChanged: (String? newValue) {
                                setState(() {
                                  location = newValue!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select location';
                                } else {
                                  return null;
                                }
                              },
                              items: locationList.map<DropdownMenuItem<String>>(
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Header(
                    text: 'Category ',
                    style: GoogleFonts.dmSans(
                        fontSize: 18,
                        color: AppColors.blue2,
                        fontWeight: FontWeight.w600),
                    alignment: Alignment.centerLeft,
                  ),
                  ListTile(
                    title: const Text('Online'),
                    leading: Radio<String>(
                      value: 'online',
                      groupValue: status,
                      activeColor: AppColors.grey2,
                      fillColor: MaterialStateProperty.all(AppColors.orange),
                      splashRadius: 20,
                      onChanged: (value) {
                        setState(() {
                          status = value;
                          // print(status!);
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Offline'),
                    leading: Radio<String>(
                      value: 'offline',
                      groupValue: status,
                      activeColor: AppColors.grey2,
                      fillColor: MaterialStateProperty.all(AppColors.orange),
                      splashRadius: 20,
                      onChanged: (value) {
                        setState(() {
                          status = value;
                          // print(status!);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ButtonTemplate(
                      height: 50,
                      width: width(context, 1.5),
                      color: AppColors.blue,
                      text1: 'APPLY NOW  ',
                      onPressed: () {
                        if (category == null) {
                          showToast(
                              text: 'choose category',
                              state: ToastStates.success);
                        }
                        if (status == null) {
                          showToast(
                              text: 'choose status',
                              state: ToastStates.success);
                        }
                        if (formKey.currentState!.validate()) {
                          print(location);
                          print(status);
                          UserCubit.get(context).getFilter(
                              category: category!,
                              location: location!,
                              status: status!);
                        }
                      },
                      textStyle: AppTextStyles.button.copyWith(fontSize: 16)),
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

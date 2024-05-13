import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/company/cubit/company_cubit.dart';
import 'package:grad_ready/models/company_model.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

import '../../../shared/components/constants.dart';
import '../company_home/view.dart';

class EditCompanyProfileScreen extends StatefulWidget {
 final  CompanyModel ? model;


  const EditCompanyProfileScreen({required this.model, super.key});

  @override
  State<EditCompanyProfileScreen> createState() => _EditCompanyProfileScreenState();
}

class _EditCompanyProfileScreenState extends State<EditCompanyProfileScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController fieldController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController missionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String? image;
 @override
  void initState() {
    nameController = TextEditingController(text: widget.model!.name!);
    fieldController = TextEditingController(text: widget.model!.field!);
    aboutController = TextEditingController(text: widget.model!.about!);
    missionController = TextEditingController(text: widget.model!.mission!);
    contactController = TextEditingController(text: widget.model!.contact!);
    image = widget.model!.image;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        if (state is UpdateCompanyInfoSuccessState) {
          showToast(text: ' update successfully', state: ToastStates.success);
          CompanyCubit.get(context).getCompanyData();
          Timer(const Duration(seconds: 1), () {
            navigateTo(context, const CompanyHomeScreen());
          });
        }
        if (state is UploadImageSuccessState) {
          showToast(text: 'add image successfully', state: ToastStates.success);

          image = state.image;
        }
        if (state is UploadImageErrorState) {
          if (kDebugMode) {
            print(state.error);
          }
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                          color: AppColors.white4,
                          image: DecorationImage(
                              image: AssetImage('assets/images/Background.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: image != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 100,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child:
                                  Image(image: NetworkImage(image!)),
                                ),
                              )
                                  : Image(
                                image: const AssetImage(
                                    'assets/images/Group 3.png'),
                                height: height(context, 7),
                              )),
                          state is UploadImageLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonTemplate(
                                color: AppColors.purple,
                                text1: 'change image',
                                onPressed: () {
                                  CompanyCubit.get(context)
                                      .updatedShowBottomSheet(context);
                                },
                                textStyle: AppTextStyles.name
                                    .copyWith(color: AppColors.white)),
                          ),
                        ],
                      ),
                    ),
                    TextFieldTemplate(
                      hintText: 'company name',
                      keyType: TextInputType.emailAddress,
                      controller: nameController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter Company  name ';
                        }
                      },
                      labelText: 'Company  name ',
                    ),
                    TextFieldTemplate(
                      hintText: 'company field',
                      keyType: TextInputType.emailAddress,
                      controller: fieldController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter Company field ';
                        }
                      },
                      labelText: 'Company field ',
                    ),
                    TextFieldTemplate(
                      hintText: 'about Company',
                      keyType: TextInputType.emailAddress,
                      controller: aboutController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter About Company ';
                        }
                      },
                      labelText: 'About Company',
                    ),
                    TextFieldTemplate(
                      hintText: 'mission and values',
                      keyType: TextInputType.emailAddress,
                      controller: missionController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter Mission and Values ';
                        }
                      },
                      labelText: 'Mission and Values',
                    ),
                    TextFieldTemplate(
                      hintText: 'contact details',
                      keyType: TextInputType.emailAddress,
                      controller: contactController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter Contact Details ';
                        }
                      },
                      labelText: 'Contact Details',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    state is UpdateCompanyInfoLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonTemplate(
                        height: 50,
                        width: width(context, 1.5),
                        color: AppColors.blue,
                        text1: 'EDIT',
                        onPressed: () {
                        if (formKey.currentState!.validate()) {
                            CompanyCubit.get(context).editCompanyInfo(
                                name: nameController.text,
                                field: fieldController.text,
                                about: aboutController.text,
                                mission: missionController.text,
                                contact: contactController.text,
                                uid: widget.model!.uid!);
                          }
                        },
                        textStyle:
                        AppTextStyles.button.copyWith(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

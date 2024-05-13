import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/admin/cubit/admin_cubit.dart';
import 'package:grad_ready/features/admin/manage_certificates/view.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';

class AddCertificatesScreen extends StatefulWidget {
  const AddCertificatesScreen({super.key});

  @override
  State<AddCertificatesScreen> createState() => _AddCertificatesScreenState();
}

class _AddCertificatesScreenState extends State<AddCertificatesScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final capacityController = TextEditingController();
  final linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AddCertificatesSuccessState) {
          showToast(
              text: 'add certificates successfully',
              state: ToastStates.success);
          Timer(const Duration(seconds: 1), () {
            navigateTo(context, const ManageCertificatesScreen());
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
              'Add Certificate',
            )),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldTemplate(
                      labelText: 'Title',
                      hintText: 'enter title of certificate',
                      keyType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter enter title of certificate';
                        }
                      },
                      controller: titleController,
                    ),
                    TextFieldTemplate(
                      labelText: 'Link',
                      hintText: 'enter link of certificate',
                      keyType: TextInputType.text,
                      controller: linkController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter link of certificate';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      labelText: 'Capacity',
                      hintText: 'enter capacity of certificate',
                      keyType: TextInputType.text,
                      controller: capacityController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter capacity of certificate';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      labelText: 'Price',
                      hintText: 'enter capacity of price',
                      keyType: TextInputType.text,
                      controller: priceController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter capacity of price';
                        }
                      },
                    ),

                    TextFieldTemplate(
                      labelText: 'Description',
                      hintText: 'enter description',
                      lines: 5,
                      keyType: TextInputType.text,
                      controller: descriptionController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return ' please , enter description of certificate';
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
                    state is AddCertificatesLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : AdminCubit.get(context).itemImageFile == null
                            ? const SizedBox()
                            : ButtonTemplate(
                                color: AppColors.blue,
                                text1: 'Send',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AdminCubit.get(context).addCertificates(
                                      title: titleController.text,
                                      link: linkController.text,
                                      capacity: capacityController.text,
                                      price: priceController.text,
                                      description: descriptionController.text,
                                    );
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

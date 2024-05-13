import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/admin/cubit/admin_cubit.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

import 'add_certificates.dart';
import 'edit_certificates.dart';

class ManageCertificatesScreen extends StatefulWidget {
  const ManageCertificatesScreen({super.key});

  @override
  State<ManageCertificatesScreen> createState() =>
      _ManageCertificatesScreenState();
}

class _ManageCertificatesScreenState extends State<ManageCertificatesScreen> {
  @override
  void initState() {
    AdminCubit.get(context).getCertificates();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is DeleteCertificatesSuccessState) {
          showToast(text: 'delete successfully', state: ToastStates.success);
          AdminCubit.get(context).getCertificates();
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Manage Certificates',
            ),
          ),
          body: ListView.builder(
            itemCount: cubit.certificatesList.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                width: width(context, 1.1),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: NetworkImage(cubit.certificatesList[index].image!),
                      height: 40,
                      width: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      cubit.certificatesList[index].title!,
                      style: AppTextStyles.sName,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      cubit.certificatesList[index].description!,
                      style: AppTextStyles.hintStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          cubit.certificatesList[index].price!,
                          style: AppTextStyles.hintStyle
                              .copyWith(fontSize: 16, color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          cubit.certificatesList[index].capacity!,
                          style: AppTextStyles.hintStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTemplate(
                            height: 35,
                            width: width(context, 3.5),
                            color: AppColors.blue,
                            text1: 'Edit',
                            onPressed: () {
                              navigateTo(
                                  context,
                                  EditCertificatesScreen(
                                    model: cubit.certificatesList[index],
                                  ));
                            },
                            textStyle:
                                AppTextStyles.button.copyWith(fontSize: 16)),
                        ButtonTemplate(
                            height: 35,
                            width: width(context, 3.5),
                            color: Colors.red,
                            text1: 'Delete',
                            onPressed: () {
                              showDialogWarning(context,
                                  text:
                                      'Are you sure to delete the Certificates',
                                  onTap: () {
                                AdminCubit.get(context).deleteCertificates(
                                    uidDoc: cubit.certificatesList[index].uid!);
                                navigatePop(context);
                              });
                            },
                            textStyle:
                                AppTextStyles.button.copyWith(fontSize: 16)),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, const AddCertificatesScreen());
            },
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

List<Map<String, dynamic>> certificate = [
  {
    'image': 'assets/images/dribbble.png',
    'name': 'Lead Designer',
    'description':
        'The best professional certificates in the field of web design',
    'price': r'$49.99',
    'capacity': '5 hr ',
  },
  {
    'image': 'assets/images/dribbble.png',
    'name': 'Lead Designer',
    'description':
        'The best professional certificates in the field of web design',
    'price': r'$49.99',
    'capacity': '5 hr ',
  },
  {
    'image': 'assets/images/dribbble.png',
    'name': 'Lead Designer',
    'description':
        'The best professional certificates in the field of web design',
    'price': r'$49.99',
    'capacity': '5 hr ',
  },
];

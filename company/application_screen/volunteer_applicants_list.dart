import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

import '../../../shared/components/navigator.dart';
import '../cubit/company_cubit.dart';

class VolunteerApplicationList extends StatefulWidget {
  const VolunteerApplicationList({super.key});

  @override
  State<VolunteerApplicationList> createState() =>
      _VolunteerApplicationListState();
}

class _VolunteerApplicationListState extends State<VolunteerApplicationList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        if (state is AcceptApplicantsSuccessState) {
          showToast(text: 'Accept successfully', state: ToastStates.success);
          CompanyCubit.get(context).getTrainingApplicants();
        }
        if (state is RejectApplicantsSuccessState) {
          showToast(text: 'Rejected successfully', state: ToastStates.success);
          CompanyCubit.get(context).getTrainingApplicants();
        }
      },
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);
        return Scaffold(
          body: ListView.builder(
            itemCount: cubit.volunteerApplicantsList.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: width(context, 1.2),
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
                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/Group 3.png'),
                          height: 40,
                          width: 70,
                        ),
                        Text(
                          cubit.volunteerApplicantsList[index].name!,
                          style: AppTextStyles.sName,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email :  ${cubit.volunteerApplicantsList[index].email!}',
                            style:
                            AppTextStyles.hintStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            'GPA : ${cubit.volunteerApplicantsList[index].gpa!}',
                            style:
                            AppTextStyles.hintStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            'Level of development : ${cubit.volunteerApplicantsList[index].level!}',
                            style:
                            AppTextStyles.hintStyle.copyWith(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Programming skills : ${cubit.volunteerApplicantsList[index].skills!}',
                            style:
                            AppTextStyles.hintStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTemplate(
                            height: 35,
                            width: width(context, 3.5),
                            color: AppColors.blue,
                            text1: 'Accept',
                            onPressed: () {
                              showDialogWarning(context,
                                  text:
                                  'Are you sure to accept the application',
                                  onTap: () {
                                    cubit.acceptApplicants(
                                        uidDoc: cubit
                                            .volunteerApplicantsList[index].uid!);
                                    navigatePop(context);
                                  });
                            },
                            textStyle:
                            AppTextStyles.button.copyWith(fontSize: 16)),
                        ButtonTemplate(
                            height: 35,
                            width: width(context, 3.5),
                            color: AppColors.purple,
                            text1: 'Reject',
                            onPressed: () {
                              showDialogWarning(context,
                                  text:
                                  'Are you sure to reject the application',
                                  onTap: () {
                                    cubit.rejectApplicants(
                                        uidDoc: cubit
                                            .volunteerApplicantsList[index].uid!);
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
        );
      },
    );
  }
}


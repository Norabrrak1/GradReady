import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/company/cubit/company_cubit.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

class TrainingApplicationList extends StatefulWidget {
  const TrainingApplicationList({super.key});

  @override
  State<TrainingApplicationList> createState() =>
      _TrainingApplicationListState();
}

class _TrainingApplicationListState extends State<TrainingApplicationList> {
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
            itemCount: cubit.trainingApplicantsList.length,
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
                          cubit.trainingApplicantsList[index].name!,
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
                            'Email :  ${cubit.trainingApplicantsList[index].email!}',
                            style:
                                AppTextStyles.hintStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            'GPA : ${cubit.trainingApplicantsList[index].gpa!}',
                            style:
                                AppTextStyles.hintStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            'Level of development : ${cubit.trainingApplicantsList[index].level!}',
                            style:
                                AppTextStyles.hintStyle.copyWith(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Programming skills : ${cubit.trainingApplicantsList[index].skills!}',
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
                                        .trainingApplicantsList[index].uid!);
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
                                        .trainingApplicantsList[index].uid!);
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

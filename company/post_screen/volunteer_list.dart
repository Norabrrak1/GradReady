import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/company/cubit/company_cubit.dart';
import 'package:grad_ready/features/company/post_screen/post_info.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

class VolunteerPostList extends StatefulWidget {
  const VolunteerPostList({super.key});

  @override
  State<VolunteerPostList> createState() => _VolunteerPostListState();
}

class _VolunteerPostListState extends State<VolunteerPostList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        if(state is DeletePostSuccessState){
          showToast(text: 'Delete post successfully', state: ToastStates.success);
          CompanyCubit.get(context).getVolunteerPost();////
        }
      },
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);////
        return Scaffold(
          body: ListView.builder(
            itemCount: cubit.volunteerPostList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  navigateTo(context,  PostInfoScreen(model: cubit.volunteerPostList[index],));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: width(context, 1.2),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image(
                            image: NetworkImage(cubit.volunteerPostList[index].image!),
                            height: 35,
                            width: 70,
                          ),
                          Text(
                            cubit.volunteerPostList[index].title!,
                            style: AppTextStyles.sName,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonTemplate(
                              height: 35,
                              width: width(context, 3.5),
                              color: AppColors.red,
                              text1: 'Delete',
                              onPressed: () {
                                showDialogWarning(context,
                                    text: 'Are you sure to delete the post',
                                    onTap: () {
                                      cubit.deletePost(uidDoc:  cubit.volunteerPostList[index].uid!);
                                      navigatePop(context);
                                    });
                              },
                              textStyle:
                              AppTextStyles.button.copyWith(fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

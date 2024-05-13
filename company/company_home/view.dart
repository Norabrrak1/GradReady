import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/company/cubit/company_cubit.dart';
import 'package:grad_ready/features/company/post_screen/view.dart';
import 'package:grad_ready/features/welcome/view.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import '../add_post/view.dart';
import '../application_screen/view.dart';
import '../profile/view.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({super.key});

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                width: width(context, 1),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              height: 100,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Image(
                                image: NetworkImage(
                                    CompanyCubit.get(context).model!.image!),
                                height: height(context, 8),
                              )),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      CompanyCubit.get(context).model!.name!,
                      style: AppTextStyles.name
                          .copyWith(color: AppColors.white, fontSize: 18),
                    ),
                    Text(
                      CompanyCubit.get(context).model!.field!,
                      style: AppTextStyles.name
                          .copyWith(color: AppColors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                 
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Box(
                                text: 'Add Post',
                                image: 'assets/images/add.png',
                                onTap: () {
                                  navigateTo(context, const AddPostScreen());
                                }),
                            Box(
                                text: 'View Applicants ',
                                image: 'assets/images/multiple-users-silhouette.png',
                                onTap: () {
                                  CompanyCubit.get(context).getTrainingApplicants();
                                  CompanyCubit.get(context).getVolunteerApplicants();
                                  navigateTo(context, const ApplicationScreen());
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Box(
                                text: 'View Posts',
                                image: 'assets/images/blogging.png',
                                onTap: () {
                                  CompanyCubit.get(context).getTrainingPost();
                                  CompanyCubit.get(context).getVolunteerPost();
                                  navigateTo(context, const PostScreen());
                                }),
                            Box(
                                text: 'Edit  Profile ',
                                image: 'assets/images/pencil.png',
                                onTap: () {
                                  navigateTo(
                                      context,
                                      EditCompanyProfileScreen(
                                        model: CompanyCubit.get(context).model!,
                                      ));
                                }),
                          ],
                        ),
                        // const Expanded(child: SizedBox()),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          width: width(context, 1.1),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.logout,
                                    color: AppColors.greyDark,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Logout',
                                    style: AppTextStyles.button
                                        .copyWith(color: AppColors.blue2, fontSize: 16),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  navigateAndReplace(context, const WelcomeScreen());
                                },
                                icon: const Icon(Icons.arrow_forward_ios_outlined),
                                color: AppColors.blue,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

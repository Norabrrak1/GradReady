import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/features/user/user_profile/edit_profile.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/images.dart';
import '../../welcome/view.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController interestsController = TextEditingController();
  TextEditingController languagesController = TextEditingController();

  @override
  void initState() {
    locationController = TextEditingController(
        text: UserCubit.get(context).userProfileModel!.location!);
    educationController = TextEditingController(
        text: UserCubit.get(context).educationList[0].university!);
    skillsController = TextEditingController(
        text: UserCubit.get(context).userProfileModel!.skills.toString());
    interestsController = TextEditingController(
        text: UserCubit.get(context).userProfileModel!.interests.toString());
    languagesController = TextEditingController(
        text: UserCubit.get(context).userProfileModel!.language.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
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
                            child: Image(
                              image:
                                  NetworkImage(cubit.userProfileModel!.image!),
                              height: height(context, 9),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.userProfileModel!.name!,
                                  style: AppTextStyles.name.copyWith(
                                      color: AppColors.white, fontSize: 15),
                                ),
                                Text(
                                  cubit.userProfileModel!.email!,
                                  style: AppTextStyles.name.copyWith(
                                      color: AppColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  cubit.userProfileModel!.phone!,
                                  style: AppTextStyles.name.copyWith(
                                      color: AppColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.blue2)),
                                onPressed: () {
                                  navigateTo(
                                      context,
                                      UserEditProfileScreen(
                                        model: cubit.userProfileModel!,
                                        educationModel: cubit.educationList,
                                      ));
                                },
                                icon: const ImageIcon(
                                  AssetImage(edit),
                                  color: AppColors.white,
                                ),
                                label: Text(
                                  'Edit profile',
                                  style: AppTextStyles.smTitles.copyWith(
                                      color: AppColors.white, fontSize: 14),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  TextFieldTemplate(
                    hintText: 'Jeddah',
                    readOnly: true,
                    keyType: TextInputType.text,
                    controller: locationController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter location';
                      }
                    },
                    labelText: 'Location  ',
                  ),
                  TextFieldTemplate(
                    readOnly: true,
                    hintText: 'Information Technology KAU ',
                    keyType: TextInputType.text,
                    controller: educationController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter Company field ';
                      }
                    },
                    labelText: 'Education',
                  ),
                  TextFieldTemplate(
                    readOnly: true,
                    hintText: 'Leader ship, Visioner',
                    keyType: TextInputType.text,
                    controller: skillsController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter About Skills ';
                      }
                    },
                    labelText: 'Skills',
                  ),
                  TextFieldTemplate(
                    readOnly: true,
                    hintText: 'Programming, Cypersecurity ,',
                    keyType: TextInputType.text,
                    controller: interestsController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter Mission and Values ';
                      }
                    },
                    labelText: 'Interests',
                  ),
                  TextFieldTemplate(
                    readOnly: true,
                    hintText: 'English, Arabic',
                    keyType: TextInputType.emailAddress,
                    controller: languagesController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please enter Language ';
                      }
                    },
                    labelText: 'Language',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                              style: AppTextStyles.button.copyWith(
                                  color: AppColors.blue2, fontSize: 16),
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
        );
      },
    );
  }
}

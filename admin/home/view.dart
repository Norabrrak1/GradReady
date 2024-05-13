import 'package:flutter/material.dart';
import 'package:grad_ready/features/admin/manage_certificates/view.dart';
import 'package:grad_ready/features/welcome/view.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

import '../manage_courses/view.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 170,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                color: AppColors.white4,
                image: DecorationImage(
                    image: AssetImage('assets/images/Background.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Row(
              children: [
                Text(
                  'Welcome \n Admin',
                  style: AppTextStyles.boldTitles2
                      .copyWith(color: AppColors.white),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 100,
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
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.litePink,
                      child: ImageIcon(
                          color: AppColors.orange,
                          size: 40,
                          AssetImage(
                            'assets/images/online-learning.png',
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Manage Courses',
                      style: AppTextStyles.button
                          .copyWith(color: AppColors.blue2, fontSize: 16),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      navigateTo(context, const ManageCoursesScreen());
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 100,
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
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.litePink,
                      child: ImageIcon(
                          color: AppColors.orange,
                          size: 40,
                          AssetImage(
                            'assets/images/certificate.png',
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Manage Certificates',
                      style: AppTextStyles.button
                          .copyWith(color: AppColors.blue2, fontSize: 16),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      navigateTo(context, const ManageCertificatesScreen());
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined))
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
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
    );
  }
}

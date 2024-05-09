import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  TextEditingController searchController = TextEditingController();

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
            body: SizedBox(
              height: height(context, 1),
              child: Column(
                children: [
                  Header(
                    text: 'Request',
                    style: GoogleFonts.dmSans(
                        fontSize: 30,
                        color: AppColors.blue2,
                        fontWeight: FontWeight.w600),
                    alignment: Alignment.center,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemCount: cubit.trainingApplicantsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: NetworkImage(cubit
                                          .trainingApplicantsList[index]
                                          .image!),
                                      height: 40,
                                      width: 60,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      cubit.trainingApplicantsList[index].type!,
                                      style: AppTextStyles.hintStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  cubit.trainingApplicantsList[index].title!,
                                  style: AppTextStyles.smSectionTitles
                                      .copyWith(fontSize: 16),
                                ),
                                Text(
                                  cubit.trainingApplicantsList[index]
                                      .description!,
                                  style: AppTextStyles.hintStyle
                                      .copyWith(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: width(context, 3),
                                      decoration: BoxDecoration(
                                        color: cubit
                                                    .trainingApplicantsList[
                                                        index]
                                                    .status ==
                                                'Under process'
                                            ? AppColors.pink2
                                            : cubit
                                                        .trainingApplicantsList[
                                                            index]
                                                        .status ==
                                                    'Accepted'
                                                ? AppColors.green
                                                : AppColors.pink3,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          cubit.trainingApplicantsList[index]
                                              .status!,
                                          style: AppTextStyles.title,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

List<Map<String, dynamic>> courses = [
  {
    'image': 'assets/images/google.png',
    'name': 'UI/UX Designer',
    'description':
        'This training program is an in-depth course tailored for both new and experienced designers focusing on UI/UX design.',
    'price': '12 June -  3 October',
    'capacity': '',
    'type': 'Training',
    'button': 'Under process',
    'color': AppColors.pink2,
  },
  {
    'image': 'assets/images/google.png',
    'name': 'UI/UX Designer',
    'description':
        'This training program is an in-depth course tailored for both new and experienced designers focusing on UI/UX design.',
    'price': '12 June -  3 October',
    'capacity': '',
    'type': 'Training',
    'button': 'Accepted',
    'color': AppColors.green,
  },
  {
    'image': 'assets/images/google.png',
    'name': 'UI/UX Designer',
    'description':
        'This training program is an in-depth course tailored for both new and experienced designers focusing on UI/UX design.',
    'price': '12 June -  3 October',
    'capacity': '',
    'type': 'Training',
    'button': 'Rejected',
    'color': AppColors.pink3,
  },
];

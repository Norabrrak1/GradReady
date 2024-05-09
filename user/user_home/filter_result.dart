import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/features/user/user_home/filter_screen.dart';
import 'package:grad_ready/features/user/user_home/training_info.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

import '../../../shared/components/navigator.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({super.key});

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
              navigateTo(context, FilterScreen());
            }),
            title: const Text(
            'Result',
            ),
          ),
          body: ListView.builder(
            itemCount: cubit.filterList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 5),
                width: width(context, 1.3),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: NetworkImage(cubit.filterList[index].image!),
                          height: 40,
                          width: 70,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          cubit.filterList[index].type!,
                          style: AppTextStyles.hintStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      cubit.filterList[index].title!,
                      style: AppTextStyles.smSectionTitles.copyWith(
                          fontSize: 16),
                    ),
                    Text(
                      cubit.filterList[index].description!,
                      style: AppTextStyles.hintStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonTemplate(
                            height: 35,
                            width: width(context, 3.5),
                            color: AppColors.grey2,
                            text1: 'view',
                            onPressed: () {
                              navigateTo(
                                  context,
                                  TrainingInfoScreen(
                                    model:  cubit.filterList[index],
                                  ));
                            },
                            textStyle: AppTextStyles.button
                                .copyWith(
                                fontSize: 16, color: AppColors.grey3)),
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

List<Map<String, dynamic>> courses = [
  {
    'image': 'assets/images/udemy.png',
    'name': 'Udemy',
    'description': 'The Complete Flutter Development with Dart. ',
    'price': r' $ 24.99 ',
    'capacity': '128 Video',
    'type': 'Course',
    'button': 'Click link'
  },
  {
    'image': 'assets/images/cisco.png',
    'name': 'Cisco',
    'description':
    'Learn basic networking concepts and skills you can put to use right away.',
    'price': 'free ',
    'capacity': '70 hours',
    'type': 'Course',
    'button': 'Click link'
  },
];

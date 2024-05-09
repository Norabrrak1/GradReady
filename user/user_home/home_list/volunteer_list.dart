import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/features/user/user_home/training_info.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';

import '../../../../models/post_model.dart';

class VolunteersList extends StatefulWidget {
  final String filter;
  const VolunteersList({required this.filter, super.key});

  @override
  State<VolunteersList> createState() => _VolunteersListState();
}

class _VolunteersListState extends State<VolunteersList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);

        return Scaffold(
          body: ListView.builder(
            itemBuilder: (context, index) {
              print(cubit.volunteerPostList.length);
              return widget.filter == ""
                  ? buildVolunteerBox(
                context,
                cubit.volunteerPostList[index],
              )
                  : cubit.volunteerPostList[index].title!
                  .toLowerCase()
                  .contains(widget.filter.toLowerCase())
                  ? buildVolunteerBox(
                context,
                cubit.volunteerPostList[index],
              )
                  : Container();
            },
            itemCount: cubit.volunteerPostList.length,
          ),
        );
      },
    );
  }
}


Widget buildVolunteerBox(BuildContext context, PostModel model) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 40,
              width: 70,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              model.type!,
              style:
              AppTextStyles.hintStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.title!,
          style: AppTextStyles.smSectionTitles.copyWith(fontSize: 16),
        ),
        Text(
          model.description!,
          style: AppTextStyles.hintStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              model.location!,
              style: AppTextStyles.hintStyle
                  .copyWith(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              '${model.start!} - ${model.end!}',
              style: AppTextStyles.hintStyle
                  .copyWith(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
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
                        model: model,
                      ));
                },
                textStyle: AppTextStyles.button
                    .copyWith(fontSize: 16, color: AppColors.grey3)),
          ],
        )
      ],
    ),
  );
}


// List<Map<String, dynamic>> courses = [
//   {
//     'image': 'assets/images/google.png',
//     'name': 'UI/UX Designer',
//     'description':
//         'This training program is an in-depth course tailored for both new and experienced designers focusing on UI/UX design.',
//     'price': '12 June -  3 October',
//     'capacity': '',
//     'type': 'Training',
//     'button': 'View',
//     'location': 'Jedhaa',
//   },
//   {
//     'image': 'assets/images/google.png',
//     'name': 'UI/UX Designer',
//     'description':
//         'This training program is an in-depth course tailored for both new and experienced designers focusing on UI/UX design.',
//     'price': '12 June -  3 October',
//     'capacity': '',
//     'type': 'Training',
//     'button': 'View',
//     'location': 'Jedhaa',
//   },
//   {
//     'image': 'assets/images/google.png',
//     'name': 'UI/UX Designer',
//     'description':
//         'This training program is an in-depth course tailored for both new and experienced designers focusing on UI/UX design.',
//     'price': '12 June -  3 October',
//     'capacity': '',
//     'type': 'Training',
//     'button': 'View',
//     'location': 'Jedhaa',
//   },
//   {
//     'image': 'assets/images/udemy.png',
//     'name': 'Udemy',
//     'description': 'The Complete Flutter Development with Dart. ',
//     'price': r' $ 24.99 ',
//     'capacity': '128 Video',
//     'type': 'Course',
//     'button': 'Click link',
//     'location': 'Jedhaa',
//   },
//   {
//     'image': 'assets/images/cisco.png',
//     'name': 'Cisco',
//     'description':
//         'Learn basic networking concepts and skills you can put to use right away.',
//     'price': 'free ',
//     'capacity': '70 hours',
//     'type': 'Course',
//     'button': 'Click link',
//     'location': 'Jedhaa',
//   },
//   {
//     'image': 'assets/images/cisco.png',
//     'name': 'Cisco',
//     'description':
//         'Learn basic networking concepts and skills you can put to use right away.',
//     'price': 'free ',
//     'capacity': '70 hours',
//     'type': 'Course',
//     'button': 'Click link',
//     'location': 'Jedhaa',
//   },
//   {
//     'image': 'assets/images/dribbble.png',
//     'name': 'Lead Designer',
//     'description':
//         'The best professional certificates in the field of web design',
//     'price': r'$49.99',
//     'capacity': '5 hr ',
//     'type': 'Professional certificates',
//     'button': 'Click link',
//     'location': 'Jedhaa',
//   },
//   {
//     'image': 'assets/images/dribbble.png',
//     'name': 'Lead Designer',
//     'description':
//         'The best professional certificates in the field of web design',
//     'price': r'$49.99',
//     'capacity': '5 hr ',
//     'type': 'Professional certificates',
//     'button': 'Click link',
//     'location': 'Jedhaa',
//   },
// ];

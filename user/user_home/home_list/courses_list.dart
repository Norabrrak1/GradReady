import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/models/course_model.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseList extends StatefulWidget {
  final String filter;
  const CourseList({required this.filter, super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
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
          body:ListView.builder(
            itemBuilder: (context, index) {
              print(cubit.coursesList.length);
              return widget.filter == ""
                  ? buildCourseBox(
                context,
                cubit.coursesList[index],
              )
                  : cubit.coursesList[index].title!
                  .toLowerCase()
                  .contains(widget.filter.toLowerCase())
                  ? buildCourseBox(
                context,
                cubit.coursesList[index],
              )
                  : Container();
            },
            itemCount: cubit.coursesList.length,
          ),
        );
      },
    );
  }
}


Widget buildCourseBox(BuildContext context, CourseModel model) {
  return Container(
    margin:
    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              style: AppTextStyles.hintStyle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.title!,
          style:
          AppTextStyles.smSectionTitles.copyWith(fontSize: 16),
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
              model.price!,
              style: AppTextStyles.hintStyle
                  .copyWith(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.capacity!,
              style: AppTextStyles.hintStyle.copyWith(fontSize: 16),
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
                text1: 'Click link',
                onPressed: () {
                  launchUrl(
                      Uri.parse(model.link!));
                },
                textStyle: AppTextStyles.button.copyWith(
                    fontSize: 16, color: AppColors.grey3)),
          ],
        )
      ],
    ),
  );
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/admin/cubit/admin_cubit.dart';
import 'package:grad_ready/features/admin/home/view.dart';
import 'package:grad_ready/features/admin/manage_courses/edit_course.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import 'add_course.dart';

class ManageCoursesScreen extends StatefulWidget {
  const ManageCoursesScreen({super.key});

  @override
  State<ManageCoursesScreen> createState() => _ManageCoursesScreenState();
}

class _ManageCoursesScreenState extends State<ManageCoursesScreen> {
  @override
  void initState() {
    AdminCubit.get(context).getCourses();
    // TODO: implement initState
    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is DeleteCourseSuccessState) {
          showToast(text: 'delete successfully', state: ToastStates.success);
          AdminCubit.get(context).getCourses();
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Manage Courses',
            ),
            leading: IconButton(
                onPressed: () {
                  navigateTo(context, const AdminHomeScreen());
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: ListView.builder(
            itemCount: cubit.coursesList.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    Image(
                      image: NetworkImage(cubit.coursesList[index].image!),
                      height: 50,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      cubit.coursesList[index].title!,
                      style: AppTextStyles.sName,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      cubit.coursesList[index].description!,
                      style: AppTextStyles.hintStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          cubit.coursesList[index].price!,
                          style: AppTextStyles.hintStyle
                              .copyWith(fontSize: 16, color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          cubit.coursesList[index].capacity!,
                          style: AppTextStyles.hintStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      cubit.coursesList[index].location!,
                      style: AppTextStyles.hintStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTemplate(
                            height: 35,
                            width: width(context, 3.5),
                            color: AppColors.blue,
                            text1: 'Edit',
                            onPressed: () {
                              navigateTo(
                                  context,
                                  EditCourseScreen(
                                    model: cubit.coursesList[index],
                                  ));
                            },
                            textStyle:
                                AppTextStyles.button.copyWith(fontSize: 16)),
                        ButtonTemplate(
                            height: 35,
                            width: width(context, 3.5),
                            color: Colors.red,
                            text1: 'Delete',
                            onPressed: () {
                              showDialogWarning(context,
                                  text: 'Are you sure to delete the course',
                                  onTap: () {
                                AdminCubit.get(context).deleteCourse(
                                    uidDoc: cubit.coursesList[index].uid!);
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, const AddCourseScreen());
            },
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

List<Map<String, dynamic>> courses = [
  {
    'image': 'assets/images/cisco.png',
    'name': 'Cisco',
    'description':
        'Learn basic networking concepts and skills you can put to use right away.',
    'price': 'free ',
    'capacity': '70 hours',
  },
  {
    'image': 'assets/images/udemy.png',
    'name': 'Udemy',
    'description': 'The Complete Flutter Development with Dart. ',
    'price': r' $ 24.99 ',
    'capacity': '128 Video',
  },
  {
    'image': 'assets/images/udemy.png',
    'name': 'Udemy',
    'description': 'The Complete Flutter Development with Dart. ',
    'price': r' $ 24.99 ',
    'capacity': '128 Video',
  },
  {
    'image': 'assets/images/cisco.png',
    'name': 'Cisco',
    'description':
        'Learn basic networking concepts and skills you can put to use right away.',
    'price': 'free ',
    'capacity': '70 hours',
  },
  {
    'image': 'assets/images/udemy.png',
    'name': 'Udemy',
    'description': 'The Complete Flutter Development with Dart. ',
    'price': r' $ 24.99 ',
    'capacity': '128 Video',
  },
  {
    'image': 'assets/images/cisco.png',
    'name': 'Cisco',
    'description':
        'Learn basic networking concepts and skills you can put to use right away.',
    'price': 'free ',
    'capacity': '70 hours',
  }
];

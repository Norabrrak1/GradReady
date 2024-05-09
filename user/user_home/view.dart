import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'filter_screen.dart';
import 'home_list/certificates_list.dart';
import 'home_list/courses_list.dart';
import 'home_list/training_list.dart';
import 'home_list/volunteer_list.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  TextEditingController searchController = TextEditingController();
  String filter = '';

  @override
  void initState() {
    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
            body: Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              width: width(context, 1),
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: Column(children: [
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
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Text(
                      //     'Welcome Peter,',
                      //     style: AppTextStyles.name
                      //         .copyWith(color: AppColors.white, fontSize: 15),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SearchTextField(
                              text: 'Search', controller: searchController),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.orange,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                                icon: const ImageIcon(
                                  AssetImage('assets/images/filter.png'),
                                  color: AppColors.white,
                                  size: 25,
                                ),
                                onPressed: () {
                                  navigateTo(context, const FilterScreen());
                                }),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: AppColors.white4,
                  height: 65,
                  child: (TabBar(
                    labelColor: AppColors.blue2,
                    unselectedLabelColor: AppColors.blue,
                    indicatorColor: AppColors.blue,
                    isScrollable: true,
                    labelStyle: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: AppColors.blue2,
                          fontWeight: FontWeight.w600),
                    ),
                    tabs: <Widget>[
                      SizedBox(
                        width: width(context, 3),
                        child: const Tab(
                          text: 'Training',
                        ),
                      ),
                      SizedBox(
                        width: width(context, 3),
                        child: const Tab(
                          text: 'Volunteers Activity',
                        ),
                      ),
                      SizedBox(
                        width: width(context, 3),
                        child: const Tab(
                          text: "Course",
                        ),
                      ),
                      SizedBox(
                        width: width(context, 3),
                        child: const Tab(
                          text: "Certificates",
                        ),
                      ),
                    ],
                  )),
                ),
                 Expanded(
                  child: SizedBox(
                    child: TabBarView(
                      children: [
                        TrainingList(filter: filter),
                        VolunteersList(filter: filter),
                        CourseList(filter: filter),
                        CertificateList(filter: filter),
                      ],
                    ),
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}

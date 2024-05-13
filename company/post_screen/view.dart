import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/company/company_home/view.dart';
import 'package:grad_ready/features/company/post_screen/training_post_list.dart';
import 'package:grad_ready/features/company/post_screen/volunteer_list.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Posts ',
            ),
            leading: IconButton(
                onPressed: () {
                  navigateTo(context, const CompanyHomeScreen());
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height,
            width: width(context, 1),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(children: [
              Container(
                color: AppColors.white4,
                height: 65,
                child: (TabBar(
                  labelColor: AppColors.blue2,
                  unselectedLabelColor: AppColors.blue,
                  indicatorColor: AppColors.blue,
                  isScrollable: false,
                  labelStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        color: AppColors.blue2,
                        fontWeight: FontWeight.w600),
                  ),
                  tabs: <Widget>[
                    SizedBox(
                      width: width(context, 2),
                      child: const Tab(
                        text: 'Training',
                      ),
                    ),
                    SizedBox(
                      width: width(context, 2),
                      child: const Tab(
                        text: "Volunteer work",
                      ),
                    ),
                  ],
                )),
              ),
              const Expanded(
                child: SizedBox(
                  child: TabBarView(
                    children: [
                      TrainingPostList(),
                      VolunteerPostList(),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

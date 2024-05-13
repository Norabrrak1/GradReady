import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/company/application_screen/training_application_list.dart';
import 'package:grad_ready/features/company/application_screen/volunteer_applicants_list.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Applicants ',
            ),
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
                      TrainingApplicationList(),
                      VolunteerApplicationList(),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

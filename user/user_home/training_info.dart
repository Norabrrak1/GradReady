import 'package:flutter/material.dart';
import 'package:grad_ready/features/user/navigation_screen/view.dart';
import 'package:grad_ready/models/post_model.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import '../../../shared/components/components.dart';
import 'apply_for_company.dart';

class TrainingInfoScreen extends StatefulWidget {
  final PostModel? model;

  const TrainingInfoScreen({required this.model, super.key});

  @override
  State<TrainingInfoScreen> createState() => _TrainingInfoScreenState();
}

class _TrainingInfoScreenState extends State<TrainingInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                navigateTo(context, const UserNavigation());
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: width(context, 1),
                    height: 200,
                    color: AppColors.white4,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: width(context, 1),
                      height: 150,
                      color: AppColors.grey2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.model!.title!,
                            style: AppTextStyles.sName,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.model!.companyName!,
                                    style: AppTextStyles.info),
                                Row(
                                  children: [
                                    const ImageIcon(
                                      AssetImage('assets/images/location.png'),
                                      color: AppColors.blue,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(widget.model!.location!,
                                        style: AppTextStyles.info),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                const ImageIcon(
                                  AssetImage(
                                      'assets/images/calendar (1).png'),
                                  color: AppColors.blue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('${widget.model!.start!} - ${widget.model!.end!}',
                                    style: AppTextStyles.info),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: width(context, 2.5),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          height: 70,
                          image: NetworkImage(widget.model!.image!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style:
                          AppTextStyles.sName.copyWith(color: AppColors.blue2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.model!.description!,
                      style: AppTextStyles.hintStyle
                          .copyWith(fontSize: 16, color: AppColors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Location',
                      style:
                          AppTextStyles.sName.copyWith(color: AppColors.blue2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.model!.location!,
                      style: AppTextStyles.hintStyle
                          .copyWith(fontSize: 16, color: AppColors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Time',
                      style:
                          AppTextStyles.sName.copyWith(color: AppColors.blue2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.model!.start!} - ${widget.model!.end!}',
                      style: AppTextStyles.hintStyle
                          .copyWith(fontSize: 16, color: AppColors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Requirements',
                      style:
                          AppTextStyles.sName.copyWith(color: AppColors.blue2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'GPA ${widget.model!.gpa!} or above',
                      style: AppTextStyles.hintStyle
                          .copyWith(fontSize: 16, color: AppColors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Level of development ${widget.model!.level!}',
                      style: AppTextStyles.hintStyle
                          .copyWith(fontSize: 16, color: AppColors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Programming skills ${widget.model!.skills!}',
                      style: AppTextStyles.hintStyle
                          .copyWith(fontSize: 16, color: AppColors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ButtonTemplate(
                    height: 50,
                    width: width(context, 1.5),
                    color: AppColors.blue,
                    text1: 'Apply Now  ',
                    onPressed: () {
                      navigateTo(context,  ApplyScreen(model: widget.model,));
                    },
                    textStyle: AppTextStyles.button.copyWith(fontSize: 16)),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}

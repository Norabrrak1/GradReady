import 'package:flutter/material.dart';
import 'package:grad_ready/features/company/post_screen/view.dart';
import 'package:grad_ready/models/post_model.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
class PostInfoScreen extends StatefulWidget {
  final PostModel model ;
  const PostInfoScreen({required this.model,  super.key});/////

  @override
  State<PostInfoScreen> createState() => _PostInfoScreenState();
}

class _PostInfoScreenState extends State<PostInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                navigateTo(context, const PostScreen());
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
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
                          widget.model.title!,
                          style: AppTextStyles.sName,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text( widget.model.companyName!, style: AppTextStyles.info),
                            Row(
                              children: [
                                const ImageIcon(
                                  AssetImage('assets/images/location.png'),
                                  color: AppColors.blue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text( widget.model.location!, style: AppTextStyles.info),
                              ],
                            ),
                            Row(
                              children: [
                                const ImageIcon(
                                  AssetImage('assets/images/calendar (1).png'),
                                  color: AppColors.blue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(widget.model.time!,
                                    style: AppTextStyles.info),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: width(context, 2.5),
                  child:  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        height: 70,
                        image: NetworkImage(widget.model.image!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: AppTextStyles.sName.copyWith(color: AppColors.blue2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.model.description!,
                    style: AppTextStyles.hintStyle
                        .copyWith(fontSize: 16, color: AppColors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Location',
                    style: AppTextStyles.sName.copyWith(color: AppColors.blue2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.model.location!,
                    style: AppTextStyles.hintStyle
                        .copyWith(fontSize: 16, color: AppColors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Time',
                    style: AppTextStyles.sName.copyWith(color: AppColors.blue2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.model.time!,
                    style: AppTextStyles.hintStyle
                        .copyWith(fontSize: 16, color: AppColors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Requirements',
                    style: AppTextStyles.sName.copyWith(color: AppColors.blue2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'GPA ${ widget.model.gpa!} or above',
                    style: AppTextStyles.hintStyle
                        .copyWith(fontSize: 16, color: AppColors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Level of development ${ widget.model.level!}',
                    style: AppTextStyles.hintStyle
                        .copyWith(fontSize: 16, color: AppColors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Programming skills ${ widget.model.skills!}',
                    style: AppTextStyles.hintStyle
                        .copyWith(fontSize: 16, color: AppColors.blue),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

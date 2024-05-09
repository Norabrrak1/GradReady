import 'package:flutter/material.dart';
import 'package:grad_ready/features/registration/login/view.dart';
import 'package:grad_ready/features/registration/sign_up/company_sign_up.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/constants.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import '../../shared/styles/images.dart';
import '../registration/sign_up/user_sign_up.dart';
import 'package:flutter/gestures.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height(context, 11),
            ),
            SizedBox(
              height: height(context, 2.2),
              width: width(context, 1.3),
              child: const Image(image: AssetImage(logo)),
            ),
            Container(
              width: width(context, 1.2),
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Get Ready For Your ',
                      style: AppTextStyles.boldTitles),
                  TextSpan(
                      text: 'Dream Job',
                      style: AppTextStyles.boldTitles.copyWith(
                        color: AppColors.orange,
                        decoration: TextDecoration.underline,
                      )),
                  TextSpan(text: '\n Here!', style: AppTextStyles.boldTitles),
                ]),
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Text(
                  'Explore all the most exciting training programs \n based on your interest and study major.',
                  style: AppTextStyles.labelStyle.copyWith(
                      color: AppColors.purple, fontSize: 15, height: 1.3),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonTemplate(
                  color: AppColors.blue,
                  text1: 'START AS COMPANY',
                  onPressed: () {
                    navigateTo(context, const CompanySignUpScreen());
                  },
                  height: 50,
                  textStyle: AppTextStyles.button.copyWith(fontSize: 14),
                ),
                ButtonTemplate(
                    color: AppColors.blue,
                    text1: 'START AS USER',
                    width: width(context, 2.5),
                    height: 50,
                    textStyle: AppTextStyles.button.copyWith(fontSize: 14),
                    onPressed: () {
                      navigateTo(context, const UserSignUpScreen());
                    }),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width(context, 1.2),
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Sing In as Admin ",
                      style: AppTextStyles.smTitles
                          .copyWith(color: AppColors.purple)),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          navigateTo(context, const LoginScreen(type: 'admin',));
                        },
                      text: 'Sign in ',
                      style: AppTextStyles.smTitles.copyWith(
                        color: AppColors.orange,
                        decoration: TextDecoration.underline,
                      )),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

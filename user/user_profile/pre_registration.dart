import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/user/navigation_screen/view.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import 'package:intl/intl.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/images.dart';
import '../cubit/user_cubit.dart';

class UserPreRegistrationScreen extends StatefulWidget {
  const UserPreRegistrationScreen({super.key});

  @override
  State<UserPreRegistrationScreen> createState() =>
      _UserPreRegistrationScreenState();
}

class _UserPreRegistrationScreenState extends State<UserPreRegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String? gender;
  List? skills = [];
  List? interest = [];
  List? language = [];

  @override
  void initState() {
    nameController =
        TextEditingController(text: UserCubit.get(context).model!.name!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is AddUserInfoSuccessState) {
          navigateTo(context, const UserNavigation());
        }
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
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
                          Align(
                              alignment: Alignment.topLeft,
                              child: cubit.itemImage == null
                                  ? Image(
                                      image: const AssetImage(
                                          'assets/images/Group 3.png'),
                                      height: height(context, 7),
                                    )
                                  : Image(
                                      image: NetworkImage(cubit.itemImage!),
                                      height: height(context, 7),
                                    )),
                          state is UploadImageLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : Align(
                                  alignment: Alignment.bottomRight,
                                  child: ButtonTemplate(
                                      color: AppColors.purple,
                                      text1: 'change image',
                                      onPressed: () {
                                        UserCubit.get(context)
                                            .showBottomSheet(context);
                                      },
                                      textStyle: AppTextStyles.name
                                          .copyWith(color: AppColors.white)),
                                ),
                        ],
                      ),
                    ),
                    TextFieldTemplate(
                      hintText: '',
                      keyType: TextInputType.name,
                      readOnly: true,
                      controller: nameController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter Full name ';
                        }
                      },
                      labelText: 'Full name ',
                    ),
                    TextFieldClicked(
                      labelText: 'Date of birth',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter Date of birth ';
                        }
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1960),
                            lastDate: DateTime(2025));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateController.text = formattedDate;
                          });
                        } else {
                          if (kDebugMode) {
                            print("Date is not selected");
                          }
                        }
                      },
                      controller: dateController,
                    ),
                    Header(
                      text: 'Gender :',
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: AppColors.blue2,
                          fontWeight: FontWeight.w600),
                      alignment: Alignment.centerLeft,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: width(context, 2.5),
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: const Text('Male'),
                            leading: Radio<String>(
                              value: 'male',
                              groupValue: gender,
                              activeColor: AppColors.grey2,
                              fillColor:
                                  MaterialStateProperty.all(AppColors.orange),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: width(context, 2.5),
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: const Text('Female'),
                            leading: Radio<String>(
                              value: 'female',
                              groupValue: gender,
                              activeColor: AppColors.grey2,
                              fillColor:
                                  MaterialStateProperty.all(AppColors.orange),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFieldTemplate(
                      hintText: '',
                      keyType: TextInputType.name,
                      controller: phoneController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter phone number';
                        }
                      },
                      labelText: 'Phone number ',
                    ),
                    TextFieldTemplate(
                      hintText: '',
                      keyType: TextInputType.name,
                      controller: locationController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter location';
                        }
                      },
                      labelText: 'Location',
                    ),
                    Container(
                      width: width(context, 1.1),
                      height: height(context, 4),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: AppColors.grey,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const ImageIcon(
                              AssetImage('assets/images/mortarboard.png'),
                              color: AppColors.orange,
                            ),
                            title: Text(
                              'Education',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  color: AppColors.blue2,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.litePink,
                                child: IconButton(
                                  onPressed: () {
                                    addEducationDialog(context, state: state);
                                  },
                                  icon: const ImageIcon(
                                      color: AppColors.orange,
                                      size: 15,
                                      AssetImage(
                                        'assets/images/add.png',
                                      )),
                                )),
                          ),
                          const Divider(
                            thickness: 1,
                            endIndent: 5,
                            indent: 5,
                          ),
                          cubit.educationList.isEmpty
                              ? const SizedBox()
                              : Expanded(
                                  child: SizedBox(
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount: cubit.educationList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      cubit.educationList[index]
                                                          .major!,
                                                      style:
                                                          AppTextStyles.title,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            editEducationDialog(
                                                                context,
                                                                state: state,
                                                                model: cubit
                                                                        .educationList[
                                                                    index]);
                                                          },
                                                          icon: const ImageIcon(
                                                            AssetImage(edit),
                                                            size: 25,
                                                            color: AppColors
                                                                .orange,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  cubit.educationList[index]
                                                      .university!,
                                                  style:
                                                      AppTextStyles.hintStyle,
                                                ),
                                                Text(
                                                  'start  ${cubit.educationList[index].start!} - end ${cubit.educationList[index].end!} .  ${cubit.educationList[index].numYears}Years',
                                                  style:
                                                      AppTextStyles.hintStyle,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                )
                        ],
                      ),
                    ),
                    Container(
                      width: width(context, 1.1),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: AppColors.grey,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const ImageIcon(
                              AssetImage('assets/images/mortarboard.png'),
                              color: AppColors.orange,
                            ),
                            title: Text(
                              'Skill',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  color: AppColors.blue2,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            endIndent: 5,
                            indent: 5,
                          ),
                          Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            children: [
                              Option(title: 'Leadership', list: skills!),
                              Option(title: 'Teamwork', list: skills!),
                              Option(title: 'Visioner', list: skills!),
                              Option(title: 'Target oriented', list: skills!),
                              Option(title: 'Consistent', list: skills!),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width(context, 1.1),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: AppColors.grey,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const ImageIcon(
                              AssetImage('assets/images/mortarboard.png'),
                              color: AppColors.orange,
                            ),
                            title: Text(
                              'Interest',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  color: AppColors.blue2,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            endIndent: 5,
                            indent: 5,
                          ),
                          Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            children: [
                              Option(
                                  title: 'Software Engineering',
                                  list: interest!),
                              Option(title: 'Programming', list: interest!),
                              Option(
                                  title: 'Database Management',
                                  list: interest!),
                              Option(title: 'Wep Development', list: interest!),
                              Option(
                                  title: 'Network Engineering',
                                  list: interest!),
                              Option(title: 'Cyber security', list: interest!),
                              Option(title: 'UI/UX Design', list: interest!),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width(context, 1.1),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: AppColors.grey,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const ImageIcon(
                              AssetImage('assets/images/mortarboard.png'),
                              color: AppColors.orange,
                            ),
                            title: Text(
                              'Language',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  color: AppColors.blue2,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            endIndent: 5,
                            indent: 5,
                          ),
                          Wrap(
                            spacing: 10.0,
                            runSpacing: 5.0,
                            children: [
                              Option(title: 'English', list: language!),
                              Option(title: 'Arabic', list: language!),
                              Option(title: 'Spanish', list: language!),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ButtonTemplate(
                        height: 50,
                        width: width(context, 1.5),
                        color: AppColors.blue,
                        text1: 'SAVE ',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            UserCubit.get(context).addUserInfo(
                                name: nameController.text,
                                birth: dateController.text,
                                gender: gender!,
                                phone: phoneController.text,
                                location: locationController.text,
                                skills: skills!,
                                interests: interest!,
                                language: language!);
                          }
                        },
                        textStyle: AppTextStyles.button.copyWith(fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

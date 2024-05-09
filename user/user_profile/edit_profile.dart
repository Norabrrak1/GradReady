import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_ready/features/user/navigation_screen/view.dart';
import 'package:grad_ready/models/user_profile_model.dart';
import 'package:grad_ready/shared/components/components.dart';
import 'package:grad_ready/shared/components/navigator.dart';
import 'package:grad_ready/shared/styles/colors.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import 'package:intl/intl.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/images.dart';
import '../cubit/user_cubit.dart';

class UserEditProfileScreen extends StatefulWidget {
  final UserProfileModel model;

  final List<EducationModel> educationModel;

  const UserEditProfileScreen(
      {required this.educationModel, required this.model, super.key});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String? gender;
  List? skills = [];
  List? interest = [];
  List? language = [];

  @override
  void initState() {
    nameController = TextEditingController(text: widget.model.name);
    dateController = TextEditingController(text: widget.model.birth!);
    phoneController = TextEditingController(text: widget.model.phone);
    locationController = TextEditingController(text: widget.model.location);
    gender = widget.model.gender;
    for (var element in widget.model.skills!) {
      skills!.add(element);
    }

    for (var element in widget.model.interests!) {
      interest!.add(element);
    }

    for (var element in widget.model.language!) {
      language!.add(element);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UpdateUserInfoSuccessState) {
          UserCubit.get(context).getUserProfile();
          showToast(text: 'updated successfully', state: ToastStates.success);
          navigateTo(context, const UserNavigation());
        }
      },
      builder: (context, state) {
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
                              child: UserCubit.get(context).itemImage == null
                                  ? Image(
                                      image: NetworkImage(widget.model.image!),
                                      height: height(context, 7),
                                    )
                                  : Image(
                                      image: NetworkImage(
                                          UserCubit.get(context).itemImage!),
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
                          Expanded(
                            child: SizedBox(
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: widget.educationModel.length,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                UserCubit.get(context)
                                                    .educationList[index]
                                                    .major!,
                                                style: AppTextStyles.title,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: IconButton(
                                                    onPressed: () {
                                                      editEducationDialog(
                                                          context,
                                                          state: state,
                                                          model: UserCubit.get(
                                                                      context)
                                                                  .educationList[
                                                              index]);
                                                    },
                                                    icon: const ImageIcon(
                                                      AssetImage(edit),
                                                      size: 25,
                                                      color: AppColors.orange,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            UserCubit.get(context)
                                                .educationList[index]
                                                .university!,
                                            style: AppTextStyles.hintStyle,
                                          ),
                                          Text(
                                            'start  ${UserCubit.get(context).educationList[index].start!} - end ${UserCubit.get(context).educationList[index].end!} .  ${UserCubit.get(context).educationList[index].numYears}Years',
                                            style: AppTextStyles.hintStyle,
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
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: skills!.length,
                                itemBuilder: (context, index) {
                                  return Wrap(
                                    children: [
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.blue3,
                                            border: Border.all(
                                              color: AppColors.blue4,
                                            )),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2.5, vertical: 5),
                                        child: Text(
                                          skills![index],
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTextStyles.hintStyle.copyWith(
                                            color: AppColors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
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
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: interest!.length,
                                itemBuilder: (context, index) {
                                  return Wrap(
                                    children: [
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.blue3,
                                            border: Border.all(
                                              color: AppColors.blue4,
                                            )),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2.5, vertical: 5),
                                        child: Text(
                                          interest![index],
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTextStyles.hintStyle.copyWith(
                                            color: AppColors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
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
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: language!.length,
                                itemBuilder: (context, index) {
                                  return Wrap(
                                    children: [
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.blue3,
                                            border: Border.all(
                                              color: AppColors.blue4,
                                            )),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2.5, vertical: 5),
                                        child: Text(
                                          language![index],
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTextStyles.hintStyle.copyWith(
                                            color: AppColors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
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
                            UserCubit.get(context).updateUserInfo(
                                name: nameController.text,
                                birth: dateController.text,
                                gender: gender!,
                                phone: phoneController.text,
                                location: locationController.text,
                                skills: skills!,
                                image: widget.model.image!,
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

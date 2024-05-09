part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetUserProfileDataLoadingState extends UserState {}

class GetUserProfileDataSuccessState extends UserState {
  GetUserProfileDataSuccessState();
}

class GetUserProfileDataErrorState extends UserState {
  late final String error;

  GetUserProfileDataErrorState(this.error);
}

class GetUserDataLoadingState extends UserState {}

class GetUserDataSuccessState extends UserState {
  GetUserDataSuccessState();
}

class GetUserDataErrorState extends UserState {
  late final String error;

  GetUserDataErrorState(this.error);
}

class GetTrainingPostLoadingState extends UserState {}

class GetTrainingPostSuccessState extends UserState {
  GetTrainingPostSuccessState();
}

class GetTrainingPostErrorState extends UserState {
  late final String error;

  GetTrainingPostErrorState(this.error);
}

class GetVolunteersPostLoadingState extends UserState {}

class GetVolunteersPostSuccessState extends UserState {
  GetVolunteersPostSuccessState();
}

class GetVolunteersPostErrorState extends UserState {
  late final String error;

  GetVolunteersPostErrorState(this.error);
}

class SubmitApplicationLoadingState extends UserState {}

class SubmitApplicationSuccessState extends UserState {
  SubmitApplicationSuccessState();
}

class SubmitApplicationErrorState extends UserState {
  late final String error;

  SubmitApplicationErrorState(this.error);
}

class GetImageSuccessState extends UserState {}

class GetImageErrorState extends UserState {
  late final String error;

  GetImageErrorState(this.error);
}

class UploadImageSuccessState extends UserState {}

class UploadImageLoadingState extends UserState {}

class UploadImageErrorState extends UserState {
  late final String error;

  UploadImageErrorState(this.error);
}

class AddEducationLoadingState extends UserState {}

class AddEducationSuccessState extends UserState {
  AddEducationSuccessState();
}

class AddEducationErrorState extends UserState {
  late final String error;

  AddEducationErrorState(this.error);
}

class AddUserInfoLoadingState extends UserState {}

class AddUserInfoSuccessState extends UserState {
  AddUserInfoSuccessState();
}

class AddUserInfoErrorState extends UserState {
  late final String error;

  AddUserInfoErrorState(this.error);
}
class UpdateUserInfoLoadingState extends UserState {}

class UpdateUserInfoSuccessState extends UserState {
  UpdateUserInfoSuccessState();
}

class UpdateUserInfoErrorState extends UserState {
  late final String error;

  UpdateUserInfoErrorState(this.error);
}

class GetEducationLoadingState extends UserState {}

class GetEducationSuccessState extends UserState {
  GetEducationSuccessState();
}

class GetEducationErrorState extends UserState {
  late final String error;

  GetEducationErrorState(this.error);
}

class UpdateEducationLoadingState extends UserState {}

class UpdateEducationSuccessState extends UserState {
  UpdateEducationSuccessState();
}

class UpdateEducationErrorState extends UserState {
  late final String error;

  UpdateEducationErrorState(this.error);
}

class ChangeBottomStaffNavState extends UserState {}



class ChangeFilterState extends UserState {}


class GetCertificatesLoadingState extends UserState {}

class GetCertificatesSuccessState extends UserState {
  GetCertificatesSuccessState();
}

class GetCertificatesErrorState extends UserState {
  late final String error;

  GetCertificatesErrorState(this.error);
}

class GetCourseLoadingState extends UserState {}

class GetCourseSuccessState extends UserState {
  GetCourseSuccessState();
}

class GetCourseErrorState extends UserState {
  late final String error;

  GetCourseErrorState(this.error);
}
class GetApplicantsLoadingState extends UserState {}

class GetApplicantsSuccessState extends UserState {
  GetApplicantsSuccessState();
}

class GetApplicantsErrorState extends UserState {
  late final String error;

  GetApplicantsErrorState(this.error);
}


class GetFilterLoadingState extends UserState {}

class GetFilterSuccessState extends UserState {
  GetFilterSuccessState();
}

class GetFilterErrorState extends UserState {
  late final String error;

  GetFilterErrorState(this.error);
}

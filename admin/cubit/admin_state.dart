part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}


class GetImageSuccessState extends AdminState {}

class GetImageErrorState extends AdminState {
  late final String error;

  GetImageErrorState(this.error);
}

class UploadImageSuccessState extends AdminState {}

class UploadImageLoadingState extends AdminState {}

class UploadImageErrorState extends AdminState {
  late final String error;

  UploadImageErrorState(this.error);
}

class AddCourseLoadingState extends AdminState {}

class AddCourseSuccessState extends AdminState {
  AddCourseSuccessState();
}

class AddCourseErrorState extends AdminState {
  late final String error;

  AddCourseErrorState(this.error);
}
class GetCourseLoadingState extends AdminState {}

class GetCourseSuccessState extends AdminState {
  GetCourseSuccessState();
}

class GetCourseErrorState extends AdminState {
  late final String error;

  GetCourseErrorState(this.error);
}

class DeleteCourseLoadingState extends AdminState {}

class DeleteCourseSuccessState extends AdminState {
  DeleteCourseSuccessState();
}

class DeleteCourseErrorState extends AdminState {
  late final String error;

  DeleteCourseErrorState(this.error);
}
class UpdateCourseLoadingState extends AdminState {}

class UpdateCourseSuccessState extends AdminState {
  UpdateCourseSuccessState();
}

class UpdateCourseErrorState extends AdminState {
  late final String error;

  UpdateCourseErrorState(this.error);
}

class AddCertificatesLoadingState extends AdminState {}

class AddCertificatesSuccessState extends AdminState {
  AddCertificatesSuccessState();
}

class AddCertificatesErrorState extends AdminState {
  late final String error;

  AddCertificatesErrorState(this.error);
}
class GetCertificatesLoadingState extends AdminState {}

class GetCertificatesSuccessState extends AdminState {
  GetCertificatesSuccessState();
}

class GetCertificatesErrorState extends AdminState {
  late final String error;

  GetCertificatesErrorState(this.error);
}

class DeleteCertificatesLoadingState extends AdminState {}

class DeleteCertificatesSuccessState extends AdminState {
  DeleteCertificatesSuccessState();
}

class DeleteCertificatesErrorState extends AdminState {
  late final String error;

  DeleteCertificatesErrorState(this.error);
}
class UpdateCertificatesLoadingState extends AdminState {}

class UpdateCertificatesSuccessState extends AdminState {
  UpdateCertificatesSuccessState();
}

class UpdateCertificatesErrorState extends AdminState {
  late final String error;

  UpdateCertificatesErrorState(this.error);
}






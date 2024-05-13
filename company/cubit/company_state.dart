part of 'company_cubit.dart';

@immutable
abstract class CompanyState {}

class CompanyInitial extends CompanyState {}


class GetCompanyDataLoadingState extends CompanyState {}

class GetCompanyDataSuccessState extends CompanyState {
  GetCompanyDataSuccessState();
}

class GetCompanyDataErrorState extends CompanyState {
  late final String error;

  GetCompanyDataErrorState(this.error);
}


class AddCompanyInfoLoadingState extends CompanyState {}

class AddCompanyInfoSuccessState extends CompanyState {
  AddCompanyInfoSuccessState();
}

class AddCompanyInfoErrorState extends CompanyState {
  late final String error;

  AddCompanyInfoErrorState(this.error);
}



class GetImageSuccessState extends CompanyState {}

class GetImageErrorState extends CompanyState {
  late final String error;

  GetImageErrorState(this.error);
}

class UploadImageSuccessState extends CompanyState {
  late final String image;

  UploadImageSuccessState(this.image);
}

class UploadImageLoadingState extends CompanyState {}

class UploadImageErrorState extends CompanyState {
  late final String error;

  UploadImageErrorState(this.error);
}


class AddPostLoadingState extends CompanyState {}

class AddPostSuccessState extends CompanyState {
  AddPostSuccessState();
}

class AddPostErrorState extends CompanyState {
  late final String error;

  AddPostErrorState(this.error);
}

class GetVolunteerPostLoadingState extends CompanyState {}

class GetVolunteerPostSuccessState extends CompanyState {
  GetVolunteerPostSuccessState();
}

class GetVolunteerPostErrorState extends CompanyState {
  late final String error;

  GetVolunteerPostErrorState(this.error);
}

class GetTrainingPostLoadingState extends CompanyState {}

class GetTrainingPostSuccessState extends CompanyState {
  GetTrainingPostSuccessState();
}

class GetTrainingPostErrorState extends CompanyState {
  late final String error;

  GetTrainingPostErrorState(this.error);
}


class DeletePostLoadingState extends CompanyState {}

class DeletePostSuccessState extends CompanyState {
  DeletePostSuccessState();
}

class DeletePostErrorState extends CompanyState {
  late final String error;

  DeletePostErrorState(this.error);
}


class UpdateCompanyInfoLoadingState extends CompanyState {}

class UpdateCompanyInfoSuccessState extends CompanyState {
  UpdateCompanyInfoSuccessState();
}

class UpdateCompanyInfoErrorState extends CompanyState {
  late final String error;

  UpdateCompanyInfoErrorState(this.error);
}
class GetTrainingApplicantsLoadingState extends CompanyState {}

class GetTrainingApplicantsSuccessState extends CompanyState {
  GetTrainingApplicantsSuccessState();
}

class GetTrainingApplicantsErrorState extends CompanyState {
  late final String error;

  GetTrainingApplicantsErrorState(this.error);
}

class GetVolunteerApplicantsLoadingState extends CompanyState {}

class GetVolunteerApplicantsSuccessState extends CompanyState {
  GetVolunteerApplicantsSuccessState();
}

class GetVolunteerApplicantsErrorState extends CompanyState {
  late final String error;

  GetVolunteerApplicantsErrorState(this.error);
}


class AcceptApplicantsLoadingState extends CompanyState {}

class AcceptApplicantsSuccessState extends CompanyState {
  AcceptApplicantsSuccessState();
}

class AcceptApplicantsErrorState extends CompanyState {
  late final String error;

  AcceptApplicantsErrorState(this.error);
}
class RejectApplicantsLoadingState extends CompanyState {}

class RejectApplicantsSuccessState extends CompanyState {
  RejectApplicantsSuccessState();
}

class RejectApplicantsErrorState extends CompanyState {
  late final String error;

  RejectApplicantsErrorState(this.error);
}

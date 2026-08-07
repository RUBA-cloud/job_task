import 'package:job_task/data/model/response/about_us_entity.dart';
import 'package:job_task/data/model/response/branch_entity.dart';

abstract class MenuDrawerState {}

/// ------------------------------
/// About Us
/// ------------------------------

class AboutUsInitial extends MenuDrawerState {}

class AboutUsLoading extends MenuDrawerState {}

class AboutUsLoaded extends MenuDrawerState {
  final AboutUsEntity aboutUs;

  AboutUsLoaded(this.aboutUs);
}

class AboutUsFailed extends MenuDrawerState {
  final String error;

  AboutUsFailed(this.error);
}

/// ------------------------------
/// Our Branches
/// ------------------------------

class OurBranchInitialState extends MenuDrawerState {}

class OurBranchLoadingState extends MenuDrawerState {}

class OurBranchLoadedState extends MenuDrawerState {
  final BranchEntity branchEntity;

  OurBranchLoadedState(this.branchEntity);
}

class OurBranchFailedState extends MenuDrawerState {
  final String error;

  OurBranchFailedState(this.error);
}

/// ------------------------------
/// Navigation
/// ------------------------------

class GoToAboutUs extends MenuDrawerState {}

class GoToContactUs extends MenuDrawerState {}

class GoToMyOrders extends MenuDrawerState {}

class GoToSettings extends MenuDrawerState {}

/// ------------------------------
/// Profile
/// ------------------------------

class ProfileInitial extends MenuDrawerState {}

class ProfileLoading extends MenuDrawerState {}

class ProfileUpdating extends MenuDrawerState {}

class ProfileUpdated extends MenuDrawerState {
  final String message;

  ProfileUpdated(this.message);
}

class ProfileFailed extends MenuDrawerState {
  final String error;

  ProfileFailed(this.error);
}

/// ------------------------------
/// Image
/// ------------------------------

class ProfileImagePicked extends MenuDrawerState {
  final String imagePath;

  ProfileImagePicked(this.imagePath);
}

class ProfileImagePickFailed extends MenuDrawerState {
  final String error;

  ProfileImagePickFailed(this.error);
}

/// ------------------------------
/// Validation
/// ------------------------------

class ProfileValidationChanged extends MenuDrawerState {}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/constants/shard_prefes_keys.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/data/model/request/auth_request/update_profile_request.dart';
import 'package:job_task/data/model/response/about_us_entity.dart';
import 'package:job_task/data/model/response/auth_entity/update_profile_entity.dart';
import 'package:job_task/data/model/response/branch_entity.dart';
import 'package:job_task/domain/use_cases/about_us/about_us_use_case.dart';
import 'package:job_task/domain/use_cases/auth/update_profile_use_case.dart';
import 'package:job_task/domain/use_cases/our_branches_use_case.dart';
import 'package:job_task/domain/use_cases/shared_pref/get_shared_pref.dart';
import 'package:job_task/services/home_drawer/home_drawer_state.dart';

class HomeDrawerCubit extends Cubit<MenuDrawerState> {
  HomeDrawerCubit() : super(AboutUsInitial());
  static HomeDrawerCubit get(BuildContext context) => BlocProvider.of<HomeDrawerCubit>(context);
  // ---------------------------------------------------------
  // Use Cases
  // ---------------------------------------------------------

  final AboutUsUseCase _aboutUsUseCase = getIt<AboutUsUseCase>();
  final OurBranchUseCase _ourBranches = getIt<OurBranchUseCase>();
  final UpdateProfileUseCase _profileUseCase = getIt<UpdateProfileUseCase>();
  final GetPrefUseCase _getPrefUseCase =  getIt<GetPrefUseCase>();
  late UpdateProfileEntity updateProfileEntity;


  // ---------------------------------------------------------
  // Data
  // ---------------------------------------------------------

  AboutUsEntity? aboutUsEntity;
  BranchEntity? branchEntity;

  // ---------------------------------------------------------
  // Profile Controllers
  // ---------------------------------------------------------

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController addressController =
  TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  File? profileImage;

  // ---------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------

  void goToAboutUs() {
    emit(GoToAboutUs());
  }

  void goToContactUs() {
    emit(GoToContactUs());
  }

  void goToMyOrders() {
    emit(GoToMyOrders());
  }

  void goToSettings() {
    emit(GoToSettings());
  }

  // ---------------------------------------------------------
  // About Us
  // ---------------------------------------------------------

  Future<void> loadProfile() async {
    final name = await _getPrefUseCase.call(SharedPrefs.userName);
    final email = await _getPrefUseCase.call(SharedPrefs.email);
    final phone = await _getPrefUseCase.call(SharedPrefs.phone);
    final imagePath = await _getPrefUseCase.call(SharedPrefs.gallery);

    nameController.text = name ?? '';
    emailController.text = email ?? '';
    phoneController.text = phone ?? '';

    // if (imagePath != null && imagePath.isNotEmpty) {
    //   profileImage = File(imagePath);
    // } else {
    //   profileImage = null;
    // }

    emit(ProfileValidationChanged());
  }

  Future<void> loadAboutUs() async {
    emit(AboutUsLoading());

    try {
      final result = await _aboutUsUseCase.execute();

      switch (result) {
        case Success<AboutUsEntity>(data: final data):
          aboutUsEntity = data;
          emit(AboutUsLoaded(data));
          break;

        case Failure<AboutUsEntity>(error: final error):
          emit(
            AboutUsFailed(
              error?.message ?? 'Unable to load about us',
            ),
          );
          break;
      }
    } catch (e) {
      emit(
        AboutUsFailed(
          e.toString(),
        ),
      );
    }
  }

  // ---------------------------------------------------------
  // Branches
  // ---------------------------------------------------------

  Future<void> loadBranches() async {
    emit(OurBranchLoadingState());

    try {
      final result = await _ourBranches.execute();

      switch (result) {
        case Success<BranchEntity>(data: final data):
          branchEntity = data;
          emit(
            OurBranchLoadedState(data),
          );
          break;

        case Failure<BranchEntity>(error: final error):
          emit(
            OurBranchFailedState(
              error?.message ?? 'Unable to load branches',
            ),
          );
          break;
      }
    } catch (e) {
      emit(
        OurBranchFailedState(
          e.toString(),
        ),
      );
    }
  }

  // =========================================================
  // PROFILE VALIDATION
  // =========================================================

  String? validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Name is required';
    }

    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePhone(String? value) {
    final phone = value?.trim() ?? '';

    if (phone.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(
      r'^\+?[0-9\s\-\(\)]{7,20}$',
    );

    if (!phoneRegex.hasMatch(phone)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  String? validateAddress(String? value) {
    final address = value?.trim() ?? '';

    if (address.isEmpty) {
      return 'Address is required';
    }

    return null;
  }

  bool validateProfile() {
    final nameError = validateName(
      nameController.text,
    );

    final emailError = validateEmail(
      emailController.text,
    );

    final phoneError = validatePhone(
      phoneController.text,
    );

    final addressError = validateAddress(
      addressController.text,
    );

    if (nameError != null ||
        emailError != null ||
        phoneError != null ||
        addressError != null) {
      emit(ProfileValidationChanged());
      return false;
    }

    return true;
  }

  // =========================================================
  // IMAGE PICKER
  // =========================================================

  Future<void> pickProfileImage() async {
    try {
      final XFile? pickedFile =
      await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile == null) {
        return;
      }

      profileImage = File(pickedFile.path);

      emit(
        ProfileImagePicked(
          pickedFile.path,
        ),
      );
    } catch (e) {
      emit(
        ProfileImagePickFailed(
          e.toString(),
        ),
      );
    }
  }

  // =========================================================
  // REMOVE IMAGE
  // =========================================================

  void removeProfileImage() {
    profileImage = null;

    emit(
      ProfileValidationChanged(),
    );
  }

  // =========================================================
  // SET PROFILE DATA
  // =========================================================

  void setProfileData({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    nameController.text = name ?? '';
    emailController.text = email ?? '';
    phoneController.text = phone ?? '';
    addressController.text = address ?? '';

    emit(
      ProfileValidationChanged(),
    );
  }

  // =========================================================
  // UPDATE PROFILE
  // =========================================================

  Future<void> updateProfile() async {
    if (!validateProfile()) {
      return;
    }

    emit(ProfileUpdating());

    try {

        final result = await _profileUseCase.execute(UpdateProfileRequest(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          address: addressController.text.trim(),
          phone: phoneController.text.trim(),));
        switch (result) {
          case Success<UpdateProfileEntity>(data: final data):
            updateProfileEntity = data;

            emit(
              ProfileUpdated(
                'Profile updated successfully',
              ),
            );
            break;

          case Failure<UpdateProfileEntity>(error: final error):
            emit(
              ProfileFailed(
                error?.message ?? 'Unable to update profile',
              ),
            );
            break;
        }



      // TODO: Replace with your real API call.

      emit(
        ProfileUpdated(
          'Profile updated successfully',
        ),
      );
    } catch (e) {
      emit(
        ProfileFailed(
          e.toString(),
        ),
      );
    }
  }

  // =========================================================
  // Dispose
  // =========================================================

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();

    return super.close();
  }
}
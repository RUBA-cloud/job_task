import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
import 'package:job_task/domain/use_cases/shared_pref/save_shared_pref.dart';

import 'package:job_task/services/home_drawer/home_drawer_state.dart';

import '../../domain/use_cases/shared_pref/remove_shared_pef_use_case.dart';

class HomeDrawerCubit extends Cubit<MenuDrawerState> {
  HomeDrawerCubit() : super(AboutUsInitial());

  static HomeDrawerCubit get(BuildContext context) {
    return BlocProvider.of<HomeDrawerCubit>(context);
  }

  // ============================================================
  // USE CASES
  // ============================================================

  final AboutUsUseCase _aboutUsUseCase = getIt<AboutUsUseCase>();

  final OurBranchUseCase _ourBranches =
  getIt<OurBranchUseCase>();

  final UpdateProfileUseCase _profileUseCase =
  getIt<UpdateProfileUseCase>();

  final GetPrefUseCase _getPrefUseCase =
  getIt<GetPrefUseCase>();

  final SavePrefUseCase _savePrefUseCase =
  getIt<SavePrefUseCase>();

  final RemovePrefUseCase _removePrefUseCase = getIt<RemovePrefUseCase>();

  // ============================================================
  // DATA
  // ============================================================

  AboutUsEntity? aboutUsEntity;

  BranchEntity? branchEntity;

  UpdateProfileEntity? updateProfileEntity;

  // ============================================================
  // PROFILE CONTROLLERS
  // ============================================================

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

  // ============================================================
  // NAVIGATION
  // ============================================================

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

  // ============================================================
  // LOAD PROFILE
  // ============================================================

  Future<void> loadProfile() async {
    try {
      final results = await Future.wait<String?>([
        _getPrefUseCase.call(SharedPrefsKeys.userName),
        _getPrefUseCase.call(SharedPrefsKeys.email),
        _getPrefUseCase.call(SharedPrefsKeys.phone),
        _getPrefUseCase.call(SharedPrefsKeys.gallery),
        _getPrefUseCase.call(SharedPrefsKeys.address),

      ]);

      nameController.text = results[0] ?? '';
      emailController.text = results[1] ?? '';
      phoneController.text = results[2] ?? '';
      addressController.text =results[4]??"";


      final imagePath = results[3];

      if (imagePath != null && imagePath.isNotEmpty) {
        final file = File(imagePath);

        if (await file.exists()) {
          profileImage = file;
        } else {
          profileImage = null;
        }
      } else {
        profileImage = null;
      }

      emit(ProfileValidationChanged());
    } catch (e) {
      emit(ProfileFailed(e.toString()));
    }
  }

  // ============================================================
  // ABOUT US
  // ============================================================

  Future<void> loadAboutUs() async {
    emit(AboutUsLoading());

    try {
      final result = await _aboutUsUseCase.execute();

      switch (result) {
        case Success<AboutUsEntity>(data: final data):
          aboutUsEntity = data;
          emit(AboutUsLoaded(data));

        case Failure<AboutUsEntity>(error: final error):
          emit(
            AboutUsFailed(
              error?.message ?? 'Unable to load about us',
            ),
          );
      }
    } catch (e) {
      emit(
        AboutUsFailed(e.toString()),
      );
    }
  }

  // ============================================================
  // BRANCHES
  // ============================================================

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

        case Failure<BranchEntity>(error: final error):
          emit(
            OurBranchFailedState(
              error?.message ?? 'Unable to load branches',
            ),
          );
      }
    } catch (e) {
      emit(
        OurBranchFailedState(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // PROFILE VALIDATION
  // ============================================================

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

  // ============================================================
  // IMAGE PICKER
  // ============================================================

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

  // ============================================================
  // REMOVE IMAGE
  // ============================================================

  void removeProfileImage() {
    profileImage = null;

    emit(
      ProfileValidationChanged(),
    );
  }

  // ============================================================
  // SET PROFILE DATA
  // ============================================================

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

  // ============================================================
  // PREPARE PROFILE REQUEST IN ISOLATE
  // ============================================================

  Future<UpdateProfileRequest> _prepareProfileRequest() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final address = addressController.text.trim();

    final avatarPath = profileImage?.path;

    final requestData = await Isolate.run(
          () => _prepareRequestData(
        name: name,
        email: email,
        phone: phone,
        address: address,
        avatarPath: avatarPath,
      ),
    );

    return UpdateProfileRequest(
      name: requestData['name'],
      email: requestData['email'],
      phone: requestData['phone'],
      address: requestData['address'],

      avatarPath: requestData['avatar_path'],
    );
  }

  // ============================================================
  // ISOLATE FUNCTION
  // ============================================================

  static Map<String, String?> _prepareRequestData({
    required String name,
    required String email,
    required String phone,
    required String address,
    String? avatarPath,
  }) {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'avatar_path': avatarPath,
    };
  }

  // ============================================================
  // UPDATE PROFILE
  // ============================================================

  Future<void> updateProfile() async {
    if (!validateProfile()) {
      return;
    }

    emit(ProfileUpdating());

    try {
      // Prepare immutable request data in isolate.
      final request = await _prepareProfileRequest();

      // API call remains outside isolate.
      final result = await _profileUseCase.execute(
        request,
      );

      switch (result) {
        case Success<UpdateProfileEntity>(data: final data):
          updateProfileEntity = data;

          // IMPORTANT: await this.
          await saveProfileUpdate(data);

          emit(
            ProfileUpdated(
              'Profile updated successfully',
            ),
          );

        case Failure<UpdateProfileEntity>(error: final error):
          emit(
            ProfileFailed(
              error?.message ?? 'Unable to update profile',
            ),
          );
      }
    } catch (e) {
      emit(
        ProfileFailed(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // SAVE PROFILE UPDATE
  // ============================================================

  Future<void> saveProfileUpdate(
      UpdateProfileEntity entity,
      ) async {
    final user = entity.user;

    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone;
    addressController.text =user.address;

    // DO NOT do:
    //
    // profileImage?.path = user.avatarPath;
    //
    // File.path is read-only.

    if (user.avatarPath.isNotEmpty) {
      profileImage = File(user.avatarPath);
    } else {
      profileImage = null;
    }

    await Future.wait([
      _savePrefUseCase.call(
        key: SharedPrefsKeys.userName,
        value: user.name,
      ),
      _savePrefUseCase.call(
        key: SharedPrefsKeys.email,
        value: user.email,
      ),
      _savePrefUseCase.call(
        key: SharedPrefsKeys.phone,
        value: user.phone,
      ),
      _savePrefUseCase.call(
        key: SharedPrefsKeys.address,
        value: user.address
      ),
      _savePrefUseCase.call(
        key: SharedPrefsKeys.gallery,
        value: user.avatarPath,
      ),
    ]);
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();

    return super.close();
  }

  void logout()async{
    _removePrefUseCase.call();
    emit(ProfileLogout());
  }
}
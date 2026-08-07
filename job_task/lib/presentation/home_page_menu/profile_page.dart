import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/services/home_drawer/home_drawer_cubit.dart';
import 'package:job_task/services/home_drawer/home_drawer_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileView();
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 late HomeDrawerCubit  homeDrawerCubit;
@override @override
  void initState() {
    homeDrawerCubit =HomeDrawerCubit.get(context);
    homeDrawerCubit.loadProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      // =========================================================
      // APP BAR
      // =========================================================
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.ink,
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.ink,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      // =========================================================
      // BLOC CONSUMER
      // =========================================================
      body: BlocConsumer<HomeDrawerCubit, MenuDrawerState>(
        // =======================================================
        // LISTENER
        // =======================================================
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(
                    color: AppColors.card,
                  ),
                ),
                backgroundColor: AppColors.accent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          if (state is ProfileFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: const TextStyle(
                    color: AppColors.card,
                  ),
                ),
                backgroundColor: AppColors.ink,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          if (state is ProfileImagePickFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: const TextStyle(
                    color: AppColors.card,
                  ),
                ),
                backgroundColor: AppColors.ink,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },

        // =======================================================
        // BUILDER
        // =======================================================
        builder: (context, state) {
          final cubit = HomeDrawerCubit.get(context);

          final bool isUpdating = state is ProfileUpdating;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // =================================================
                    // PROFILE IMAGE
                    // =================================================
                    _ProfileImage(
                      cubit: cubit,
                    ),

                    SizedBox(height: 30.h),

                    // =================================================
                    // NAME
                    // =================================================
                    _ProfileTextField(
                      controller: cubit.nameController,
                      label: 'Name',
                      hint: 'Enter your name',
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: cubit.validateName,
                    ),

                    SizedBox(height: 16.h),

                    // =================================================
                    // EMAIL
                    // =================================================
                    _ProfileTextField(
                      controller: cubit.emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: cubit.validateEmail,
                    ),

                    SizedBox(height: 16.h),

                    // =================================================
                    // PHONE
                    // =================================================
                    _ProfileTextField(
                      controller: cubit.phoneController,
                      label: 'Phone',
                      hint: 'Enter your phone number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      validator: cubit.validatePhone,
                    ),

                    SizedBox(height: 16.h),

                    // =================================================
                    // ADDRESS
                    // =================================================
                    _ProfileTextField(
                      controller: cubit.addressController,
                      label: 'Address',
                      hint: 'Enter your address',
                      icon: Icons.location_on_outlined,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.done,
                      maxLines: 2,
                      validator: cubit.validateAddress,
                    ),

                    SizedBox(height: 30.h),

                    // =================================================
                    // UPDATE BUTTON
                    // =================================================
                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: isUpdating
                            ? null
                            : () {
                          FocusScope.of(context).unfocus();

                          // Validate form first
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          // Submit
                          cubit.updateProfile();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.card,
                          disabledBackgroundColor: AppColors.textGrey,
                          disabledForegroundColor: AppColors.card,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: isUpdating
                            ? SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.card,
                          ),
                        )
                            : const Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ====================================================================
// PROFILE IMAGE
// ====================================================================

class _ProfileImage extends StatelessWidget {
  final HomeDrawerCubit cubit;

  const _ProfileImage({
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.card,
              border: Border.all(
                color: AppColors.accent,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: _buildImage(),
            ),
          ),

          // ========================================================
          // CAMERA BUTTON
          // ========================================================
          GestureDetector(
            onTap: () {
              cubit.pickProfileImage();
            },
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.surface,
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.card,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final File? image = cubit.profileImage;

    if (image != null) {
      return Image.file(
        image,
        fit: BoxFit.cover,
        width: 120.w,
        height: 120.w,
      );
    }

    return Icon(
      Icons.person,
      color: AppColors.textGrey,
      size: 65.sp,
    );
  }
}

// ====================================================================
// PROFILE TEXT FIELD
// ====================================================================

class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final String? Function(String?)? validator;

  final int maxLines;

  const _ProfileTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================================================
        // LABEL
        // ==========================================================
        Text(
          label,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 8.h),

        // ==========================================================
        // FIELD
        // ==========================================================
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 15.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textGrey,
              fontSize: 14.sp,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.textGrey,
              size: 22.sp,
            ),
            filled: true,
            fillColor: AppColors.card,

            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 15.h,
            ),

            // ======================================================
            // NORMAL
            // ======================================================
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide.none,
            ),

            // ======================================================
            // ENABLED
            // ======================================================
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide.none,
            ),

            // ======================================================
            // FOCUSED
            // ======================================================
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 1.5,
              ),
            ),

            // ======================================================
            // ERROR
            // ======================================================
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 1,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
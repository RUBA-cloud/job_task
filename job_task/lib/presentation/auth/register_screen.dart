import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';
import 'package:job_task/data/model/request/auth_request/register_request.dart';
import 'package:job_task/presentation/auth/verify_email_screen.dart';

import 'package:job_task/presentation/widget/app_text_filed.dart';
import 'package:job_task/services/auth/register/register_cubit.dart';
import 'package:job_task/services/auth/register/register_state.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Utility {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  late RegisterCubit registerCubit;
  @override void initState() {
    // TODO: implement initState
    registerCubit = RegisterCubit.get(context);
    registerCubit.getLocation();
    super.initState();
  }

  void register(BuildContext context) {
    registerCubit.register(
      request: RegisterRequest(
        name: nameController.text.trim(),

        email: emailController.text.trim(),

        phone: phoneController.text.trim(),

        password: passwordController.text.trim(),

        country: "Jordan",

        city: "Amman",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessfulState) {
          navigateTo(context, BlocProvider.value(value: registerCubit, child: VerifyEmailScreen(email:emailController.text.trim() ,)));
        }

        if (state is RegisterFailedState) {
          showSnack(context, state.error, AppColors.accent);
        }
      },

      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);

          final loading = state is RegisterLoadingState;

          return Scaffold(
            body: Container(
              width: double.infinity,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,

                  end: Alignment.bottomCenter,

                  colors: [AppColors.accent, AppColors.surface],
                ),
              ),

              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.w),

                    child: Container(
                      padding: EdgeInsets.all(28.w),

                      decoration: BoxDecoration(
                        color: AppColors.card,

                        borderRadius: BorderRadius.circular(35.r),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .15),

                            blurRadius: 30,

                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Center(
                            child: Container(
                              width: 100.w,

                              height: 100.w,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color: AppColors.accent,
                              ),

                              child: Icon(
                                Icons.person_add_alt_1,

                                size: 55.sp,

                                color: AppColors.card
                              ),
                            ),
                          ),

                          SizedBox(height: 25.h),

                          Text(
                            "Create Account",

                            style: TextStyle(
                              fontSize: 30.sp,

                              fontWeight: FontWeight.bold,

                              color: AppColors.ink,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            "Register to continue",

                            style: TextStyle(
                              fontSize: 15.sp,

                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: 35.h),

                          AppTextField(
                            controller: nameController,

                            hint: "Full Name",

                            prefixIcon: Icons.person_outline,
                          ),

                          SizedBox(height: 18.h),

                          AppTextField(
                            controller: emailController,

                            hint: "Email Address",

                            prefixIcon: Icons.email_outlined,

                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: 18.h),

                          AppTextField(
                            controller: phoneController,

                            hint: "Phone Number",

                            prefixIcon: Icons.phone_outlined,

                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(height: 18.h),

                          AppTextField(
                            controller: passwordController,
                            hint: "Password",
                            prefixIcon: Icons.lock_outline,
                            obscureText: cubit.hidePassword,
                            suffixIcon: IconButton(
                              onPressed: () => cubit.changePasswordVisibility(),
                              icon: Icon(cubit.hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ),
                          SizedBox(height: 18.h),
                          AppTextField(

                            controller: rePasswordController,
                            hint: "Renter Password",
                            prefixIcon: Icons.lock_outline,
                            obscureText: cubit.hideConfirmPassword,
                            suffixIcon: IconButton(
                              onPressed: ()=>cubit.changeConfirmPasswordVisibility(),
                              icon: Icon(
                                cubit.hideConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,

                                color: AppColors.textGrey,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),

                          SizedBox(
                            width: double.infinity,

                            height: 55.h,

                            child: ElevatedButton(
                              onPressed: loading
                                  ? null
                                  : () => register(context),

                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,

                                elevation: 0,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),

                              child: loading
                                  ? const SizedBox(
                                      width: 25,

                                      height: 25,

                                      child: CircularProgressIndicator(
                                        color:AppColors.accent,
                                      ),
                                    )
                                  : Text(
                                      "REGISTER", style: TextStyle(
                                        color: AppColors.card,
                                        fontSize: 16.sp,

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Text("Already have account?"),

                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },

                                child: Text(
                                  "Login",

                                  style: TextStyle(
                                    color: AppColors.accent,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();

    phoneController.dispose();

    passwordController.dispose();

    super.dispose();
  }
}

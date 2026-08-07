import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';
import 'package:job_task/data/model/request/auth_request/login_request.dart';
import 'package:job_task/presentation/auth/forget_password_screen.dart';
import 'package:job_task/presentation/auth/register_screen.dart';
import 'package:job_task/presentation/auth/verify_email_screen.dart';
import 'package:job_task/presentation/home_page/home_page.dart';
import 'package:job_task/presentation/widget/app_text_filed.dart';
import 'package:job_task/services/auth/login/login_cubit.dart';
import 'package:job_task/services/auth/login/login_state.dart';
import 'package:job_task/services/auth/register/register_cubit.dart';
import 'package:job_task/services/home_page/home_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Utility {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late LoginCubit cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = LoginCubit.get(context);
  }

  Future<void> login() async {
    await cubit.submitLogin(
      loginRequest: LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        country: "amman",
        city: "amman",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessful) {
          navigateTo(
            context,
            BlocProvider(create: (_) => HomeCubit(), child: const HomePage()),
          );
        }
        if (state is CheckEmailVerifiedFailed) {
          navigateTo(
            context,
            BlocProvider(create: (_) => RegisterCubit(), child: VerifyEmailScreen(email:emailController.text,)),
          );
        }


        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? "Login failed")),
          );
        }

        if (state is GoToForgetPassword) {
          navigateTo(
            context,
            BlocProvider.value(
              value: cubit,
              child: const ForgetPasswordScreen(),
            ),
          );
        }

        if (state is GoToRegister) {
          navigateTo(
            context,
            BlocProvider(
                create: (_) => RegisterCubit(),
              child: const RegisterScreen()
            ),
          );
        }
      },

      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final loading = state is LoginLoading;

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
                        borderRadius: BorderRadius.circular(35),

                        boxShadow: [
                          BoxShadow(
                            color:AppColors.blackColor,
                            blurRadius: 30,

                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Container(
                            height: 100.w,

                            width: 100.w,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              color: AppColors.accent,
                            ),

                            child: Icon(
                                Icons.lock_person_rounded,
                              size: 55.sp,
                              color:AppColors.card
                            ),
                          ),

                          SizedBox(height: 25.h),

                          Text(
                            "Welcome Back",

                            style: TextStyle(
                              fontSize: 30.sp,

                              fontWeight: FontWeight.bold,

                              color: AppColors.ink,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            "Login to continue",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.textGreyDark,
                            ),
                          ),

                          SizedBox(height: 35.h),

                          AppTextField(
                            controller: emailController,
                            hint: "Email Address",
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: 18.h),

                          AppTextField(
                            controller: passwordController,
                            hint: "Password",
                            prefixIcon: Icons.lock_outline,
                            obscureText: cubit.hidePassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              icon: Icon(
                                cubit.hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>cubit.goToPassword(),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10.h),

                          SizedBox(
                            width: double.infinity,

                            height: 55.h,

                            child: ElevatedButton(
                              onPressed: loading ? null : login,

                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),

                              child: loading
                                  ? SizedBox(
                                      height: 25,

                                      width: 25,

                                      child: CircularProgressIndicator(
                                        color: AppColors.textGreyDark
                                      ),
                                    )
                                  : Text(
                                      "LOGIN",

                                      style: TextStyle(
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
                              const Text("Don't have an account?"),

                              TextButton(
                                onPressed: () {
                                  cubit.goToRegister();
                                },

                                child: Text(
                                  "Register",

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
    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }
}

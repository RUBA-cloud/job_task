import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/bloc_observer.dart';
import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/presentation/auth/login_screen.dart';
import 'package:job_task/presentation/home_page/home_page.dart';
import 'package:job_task/services/auth/login/login_cubit.dart';
import 'package:job_task/services/auth/login/login_state.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await  configureDependencies();
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          ),
          home: BlocProvider(
            create: (context) => LoginCubit()..checkIfUserLoggedIn(),
        child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
        if (state is UserAlreadyLoggedIn) {
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
        builder: (_) => BlocProvider(create: (s)=>HomeCubit(),
            child: const HomePage()),
        ),
        (route) => false,
        );
        return;
        }


        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
        builder: (_) => BlocProvider(create: (s)=>LoginCubit(),
            child: const LoginScreen()),
        ),
        (route) => false,
        );
        },

        child: const Scaffold(
        body: Center(
        child: CircularProgressIndicator(),
        ),
        ),
        ),
        ),
        );
      },
    );
  }
}


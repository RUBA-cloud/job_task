import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/bloc_observer.dart';
import 'package:job_task/core/di/sql_lite_connection.dart';

import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/presentation/home_page/home_page.dart';
import 'package:job_task/services/home_page/home_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  // Open the SAME instance GetIt hands to the repo — not a new one.
  await getIt<SqlLiteConnection>().open();

  // Register the observer BEFORE runApp so every Bloc/Cubit is tracked.
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
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          ),
          home: BlocProvider(
            create: (context) => getIt<HomeCubit>()..loadProducts(),
            child: const HomePage(),
          ),
        );
      },
    );
  }
}


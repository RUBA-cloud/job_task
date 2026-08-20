import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/services/home_drawer/home_drawer_cubit.dart';
import 'package:job_task/services/home_drawer/home_drawer_state.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
late   HomeDrawerCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = HomeDrawerCubit.get(context);
   _cubit.loadAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: BlocBuilder<HomeDrawerCubit, MenuDrawerState>(
        builder: (context, state) {
          if (state is  AboutUsLoading ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AboutUsFailed) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is AboutUsLoaded) {
            final company = state.aboutUs.company;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.nameEn,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "About Us",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(company.aboutUsEn),

                  const SizedBox(height: 24),

                  const Text(
                    "Mission",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(company.missionEn),

                  const SizedBox(height: 24),

                  const Text(
                    "Vision",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(company.visionEn),

                  const SizedBox(height: 24),

                  const Text(
                    "Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(company.addressEn),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
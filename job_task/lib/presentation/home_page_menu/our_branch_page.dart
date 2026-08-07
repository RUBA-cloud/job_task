import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:job_task/data/model/response/branch_entity.dart';
import 'package:job_task/services/home_drawer/home_drawer_cubit.dart';
import 'package:job_task/services/home_drawer/home_drawer_state.dart';


class OurBranchesScreen extends StatefulWidget {
  const OurBranchesScreen({super.key});

  @override
  State<OurBranchesScreen> createState() => _OurBranchesScreenState();
}

class _OurBranchesScreenState extends State<OurBranchesScreen> {

  late HomeDrawerCubit homeDrawerCubit;

  @override
  void initState() {
homeDrawerCubit =HomeDrawerCubit.get(context);
homeDrawerCubit.loadBranches();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {



    return Scaffold(

      appBar: AppBar(
        title: const Text("Our Branches"),
        centerTitle: true,
      ),


      body: BlocListener<HomeDrawerCubit, MenuDrawerState>(

        listener: (context, state) {

          if (state is OurBranchFailedState) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );

          }

        },


        child: BlocBuilder<HomeDrawerCubit, MenuDrawerState>(

          builder: (context, state) {


            if (state is OurBranchLoadingState) {

              return const Center(
                child: CircularProgressIndicator(),
              );

            }


            if (state is OurBranchFailedState) {

              return Center(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Text(
                      state.error,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),


                    const SizedBox(height: 20),


                    ElevatedButton(

                      onPressed: () {

                        context
                            .read<HomeDrawerCubit>()
                            .loadBranches();

                      },

                      child: const Text(
                        "Retry",
                      ),

                    ),

                  ],

                ),

              );

            }


            if (state is OurBranchLoadedState) {


              final branches =
                  state.branchEntity.branches.data;



              if (branches.isEmpty) {

                return const Center(
                  child: Text(
                    "No branches found",
                  ),
                );

              }


              return ListView.separated(

                padding: const EdgeInsets.all(16),

                itemCount: branches.length,


                separatorBuilder: (_, _) =>
                const SizedBox(height: 16),


                itemBuilder: (context, index) {

                  return BranchCard(
                    branch: branches[index],
                  );

                },

              );

            }


            return const SizedBox();

          },

        ),

      ),

    );

  }
}



class BranchCard extends StatelessWidget {

  final BranchBranchesDataEntity branch;


  const BranchCard({
    super.key,
    required this.branch,
  });


  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),


      child: Padding(

        padding: const EdgeInsets.all(18),


        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,


          children: [

            Row(

              children: [

                const CircleAvatar(

                  radius: 22,

                  child: Icon(
                    Icons.location_city,
                  ),

                ),


                const SizedBox(width: 12),


                Expanded(

                  child: Text(

                    branch.nameEn,

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

              ],

            ),



            const SizedBox(height: 18),



            _infoRow(
              Icons.location_on,
              Colors.red,
              branch.addressEn,
            ),



            _infoRow(
              Icons.email_outlined,
              Colors.blue,
              branch.email,
            ),



            if (branch.phone != null)

              _infoRow(
                Icons.phone,
                Colors.green,
                branch.phone!,
              ),



            _infoRow(

              Icons.access_time,

              Colors.orange,

              "${branch.workingHoursFrom} - ${branch.workingHoursTo}",

            ),



            _infoRow(

              Icons.calendar_today,

              Colors.deepPurple,

              branch.workingDays,

            ),



            const SizedBox(height: 18),



            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: () {

                  // open map

                },


                icon: const Icon(Icons.map),


                label: const Text(
                  "View on Map",
                ),

              ),

            ),

          ],

        ),

      ),

    );

  }



  Widget _infoRow(
      IconData icon,
      Color color,
      String text,
      ) {

    return Padding(

      padding: const EdgeInsets.only(
        top: 10,
      ),

      child: Row(

        crossAxisAlignment:
        CrossAxisAlignment.start,


        children: [

          Icon(
            icon,
            color: color,
          ),


          const SizedBox(width: 8),


          Expanded(
            child: Text(text),
          ),

        ],

      ),

    );

  }

}
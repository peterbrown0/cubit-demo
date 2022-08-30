import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recru_test/repository/recruiters_repository_local.dart';

import '../../bloc/recruiters_bloc.dart';

class RecruitersScreen extends StatefulWidget {
  const RecruitersScreen({Key? key}) : super(key: key);

  @override
  State<RecruitersScreen> createState() => _RecruitersScreenState();
}

class _RecruitersScreenState extends State<RecruitersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (blocContext) => RecruitersCubit(
          blocContext.read<RecruitersRepositoryLocal>(),
        )..loadRecruiters('query'),
        child: Center(
          child: BlocBuilder<RecruitersCubit, RecruitersState>(
            builder: (context, state) => state.maybeWhen(
              initial: () => const Text("Initial"),
              loading: () => const Text("Loading"),
              error: (e) => const Text("Error"),
              // loaded: (recruitersList) => const Text("Recruiters list"),
              loaded: (recruitersList) => ListView.builder(
                itemCount: recruitersList.length,
                itemBuilder: ((context, index) {
                  return Text(recruitersList[index].surname);
                }),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ),
        ),
      ),
      // TODO: Add implementation for handling all BLoC states,
      // No need for a fancy UI, simple Texts would be enough
    );
  }
}

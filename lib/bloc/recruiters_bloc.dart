import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recru_test/repository/recruiters_repository.dart';

import '../model/recruiter.dart';

part 'recruiters_bloc.freezed.dart';

part 'recruiters_state.dart';

class RecruitersCubit extends Cubit<RecruitersState> {
  RecruitersCubit(this._recruitersRepository)
      : super(const RecruitersState.initial());

  final RecruitersRepository _recruitersRepository;

  void loadRecruiters(String query) async {
    emit(const RecruitersState.loading());
    try {
      final recruitersList = await _recruitersRepository.getRecruiters(query);
      emit(RecruitersState.loaded(recruitersList));
    } on Exception catch (exception) {
      emit(RecruitersState.error(exception));
    }
    // TODO: Fetch recruiters list and emit valid states
  }
}

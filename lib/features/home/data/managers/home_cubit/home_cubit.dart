import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/home/data/models/dosh_data_model.dart';
import 'package:supercycle_app/features/home/data/models/dosh_type_model.dart'
    show DoshTypeModel;
import 'package:supercycle_app/features/home/data/models/type_history_model.dart';
import 'package:supercycle_app/features/home/data/repos/home_repo_imp.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImp homeRepo;

  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  Future<void> fetchDoshTypes() async {
    emit(FetchDoshTypesLoading());
    try {
      var result = await homeRepo.fetchDoshTypes();
      result.fold(
        (failure) {
          emit(FetchDoshTypesFailure(message: failure.errMessage));
        },
        (types) {
          emit(FetchDoshTypesSuccess(doshTypes: types));
          // Store user globally
        },
      );
    } catch (error) {
      emit(FetchDoshTypesFailure(message: error.toString()));
    }
  }

  Future<void> fetchTypeHistory({required String typeId}) async {
    emit(FetchTypeHistoryLoading());
    try {
      var result = await homeRepo.fetchTypeHistory(typeId: typeId);
      result.fold(
        (failure) {
          emit(FetchTypeHistoryFailure(message: failure.errMessage));
        },
        (history) {
          emit(FetchTypeHistorySuccess(history: history));
          // Store user globally
        },
      );
    } catch (error) {
      emit(FetchTypeHistoryFailure(message: error.toString()));
    }
  }

  Future<void> fetchTypesData() async {
    emit(FetchTypesDataLoading());
    try {
      var result = await homeRepo.fetchTypesData();
      result.fold(
        (failure) {
          emit(FetchTypesDataFailure(message: failure.errMessage));
        },
        (data) {
          emit(FetchTypesDataSuccess(doshData: data));
          // Store user globally
        },
      );
    } catch (error) {
      emit(FetchTypesDataFailure(message: error.toString()));
    }
  }
}

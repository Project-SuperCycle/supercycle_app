import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle/features/environment/data/repos/environment_repo_imp.dart';
import 'package:supercycle/features/trader_main_profile/data/models/environmental_redeem_model.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final EnvironmentRepoImp environmentRepoImp;
  RequestsCubit({required this.environmentRepoImp}) : super(RequestsInitial());

  Future<void> getTraderEcoRequests() async {
    emit(RequestsLoading());
    try {
      var result = await environmentRepoImp.getTraderEcoRequests();
      result.fold(
        (failure) {
          emit(RequestsFailure(errMessage: failure.errMessage));
        },
        (requests) {
          emit(RequestsSuccess(requests: requests));
          // Store user globally
        },
      );
    } catch (error) {
      emit(RequestsFailure(errMessage: error.toString()));
    }
  }
}

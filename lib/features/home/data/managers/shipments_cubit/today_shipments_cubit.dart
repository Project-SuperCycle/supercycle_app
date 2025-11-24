import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle/features/home/data/repos/home_repo_imp.dart';
import 'package:supercycle/features/shipments_calendar/data/models/shipment_model.dart';

part 'today_shipments_state.dart';

class TodayShipmentsCubit extends Cubit<TodayShipmentsState> {
  final HomeRepoImp homeRepo;
  TodayShipmentsCubit({required this.homeRepo})
    : super(TodayShipmentsInitial());

  Future<void> fetchTodayShipments() async {
    emit(TodayShipmentsLoading());
    try {
      var result = await homeRepo.fetchTodayShipmets();
      result.fold(
        (failure) {
          emit(TodayShipmentsFailure(message: failure.errMessage));
        },
        (shipments) {
          emit(TodayShipmentsSuccess(shipments: shipments));
          // Store user globally
        },
      );
    } catch (error) {
      emit(TodayShipmentsFailure(message: error.toString()));
    }
  }
}

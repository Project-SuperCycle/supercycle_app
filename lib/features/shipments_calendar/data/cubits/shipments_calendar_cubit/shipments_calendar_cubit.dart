import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_state.dart';
import 'package:supercycle_app/features/shipments_calendar/data/repos/shipments_calendar_repo_imp.dart';

class ShipmentsCalendarCubit extends Cubit<ShipmentsCalendarState> {
  final ShipmentsCalendarRepoImp shipmentsCalendarRepo;

  ShipmentsCalendarCubit({required this.shipmentsCalendarRepo})
    : super(ShipmentsCalendarInitial());

  Future<void> getAllShipments() async {
    emit(GetAllShipmentsLoading());
    try {
      var result = await shipmentsCalendarRepo.getAllShipments();
      result.fold(
        (failure) {
          emit(GetAllShipmentsFailure(errorMessage: failure.errMessage));
        },
        (shipments) {
          emit(GetAllShipmentsSuccess(shipments: shipments));
          // Store user globally
        },
      );
    } catch (error) {
      emit(GetAllShipmentsFailure(errorMessage: error.toString()));
    }
  }

  Future<void> getAllRepShipments() async {
    emit(GetAllShipmentsLoading());
    try {
      var result = await shipmentsCalendarRepo.getAllRepShipments();
      result.fold(
        (failure) {
          emit(GetAllShipmentsFailure(errorMessage: failure.errMessage));
        },
        (shipments) {
          emit(GetAllShipmentsSuccess(shipments: shipments));
          // Store user globally
        },
      );
    } catch (error) {
      emit(GetAllShipmentsFailure(errorMessage: error.toString()));
    }
  }

  Future<void> getShipmentById({required String shipmentId}) async {
    emit(GetShipmentLoading());
    try {
      var result = await shipmentsCalendarRepo.getShipmentById(
        shipmentId: shipmentId,
      );
      result.fold(
        (failure) {
          emit(GetShipmentFailure(errorMessage: failure.errMessage));
        },
        (shipment) {
          emit(GetShipmentSuccess(shipment: shipment));
          // Store user globally
        },
      );
    } catch (error, stackTrace) {
      emit(GetShipmentFailure(errorMessage: error.toString()));
    }
  }
}

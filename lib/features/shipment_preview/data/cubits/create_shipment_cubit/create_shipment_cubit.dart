import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/features/sales_process/data/models/create_shipment_model.dart';
import 'package:supercycle_app/features/shipment_preview/data/repos/shipment_preview_repo_imp.dart';

part 'create_shipment_state.dart';

class CreateShipmentCubit extends Cubit<CreateShipmentState> {
  final ShipmentReviewRepoImp shipmentDetailsRepo;
  CreateShipmentCubit({required this.shipmentDetailsRepo})
    : super(CreateShipmentInitial());

  Future<void> createShipment({required FormData shipment}) async {
    emit(CreateShipmentLoading());
    try {
      var result = await shipmentDetailsRepo.createShipment(shipment: shipment);
      result.fold(
        (failure) {
          emit(CreateShipmentFailure(errorMessage: failure.errMessage));
        },
        (message) {
          emit(CreateShipmentSuccess(message: message));
          // Store user globally
        },
      );
      Logger().i("CREATE CUBIT");
    } catch (error) {
      emit(CreateShipmentFailure(errorMessage: error.toString()));
    }
  }
}

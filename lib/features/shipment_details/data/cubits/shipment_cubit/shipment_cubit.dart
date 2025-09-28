import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/features/shipment_details/data/repos/shipment_details_repo_imp.dart';

part 'shipment_state.dart';

class ShipmentCubit extends Cubit<ShipmentState> {
  final ShipmentDetailsRepoImp shipmentDetailsRepo;
  ShipmentCubit({required this.shipmentDetailsRepo}) : super(ShipmentInitial());

  Future<void> cancelShipment({required String shipmentId}) async {
    emit(CancelShipmentLoading());
    try {
      var result = await shipmentDetailsRepo.cancelShipment(
        shipmentId: shipmentId,
      );
      result.fold(
        (failure) {
          emit(CancelShipmentFailure(errorMessage: failure.errMessage));
        },
        (message) {
          emit(CancelShipmentSuccess(message: message));
          // Store user globally
        },
      );
      Logger().i("CANCEL SHIPMENT CUBIT");
    } catch (error) {
      emit(CancelShipmentFailure(errorMessage: error.toString()));
    }
  }
}

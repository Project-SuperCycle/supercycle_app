import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle/features/representative_shipment_details/data/cubits/reject_shipment_cubit/reject_shipment_state.dart';
import 'package:supercycle/features/representative_shipment_details/data/models/reject_shipment_model.dart';
import 'package:supercycle/features/representative_shipment_details/data/repos/rep_shipment_details_repo_imp.dart';

class RejectShipmentCubit extends Cubit<RejectShipmentState> {
  final RepShipmentDetailsRepoImp repShipmentDetailsRepo;
  RejectShipmentCubit({required this.repShipmentDetailsRepo})
    : super(RejectRepShipmentInitial());

  Future<void> rejectShipment({
    required RejectShipmentModel rejectModel,
  }) async {
    emit(RejectRepShipmentLoading());
    try {
      var result = await repShipmentDetailsRepo.rejectShipment(
        rejectModel: rejectModel,
      );
      result.fold(
        (failure) {
          emit(RejectRepShipmentFailure(errorMessage: failure.errMessage));
        },
        (message) {
          emit(RejectRepShipmentSuccess(message: message));
        },
      );
      Logger().i("REJECT SHIPMENT CUBIT");
    } catch (error) {
      emit(RejectRepShipmentFailure(errorMessage: error.toString()));
    }
  }
}

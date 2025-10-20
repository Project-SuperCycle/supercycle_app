import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/cubits/reject_shipment_cubit/reject_shipment_state.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/repos/rep_shipment_details_repo_imp.dart';

class RejectShipmentCubit extends Cubit<RejectShipmentState> {
  final RepShipmentDetailsRepoImp repShipmentDetailsRepo;
  RejectShipmentCubit({required this.repShipmentDetailsRepo})
    : super(RejectRepShipmentInitial());
}

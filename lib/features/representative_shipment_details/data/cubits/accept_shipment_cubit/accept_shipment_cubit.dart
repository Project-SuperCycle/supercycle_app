import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/cubits/accept_shipment_cubit/accept_shipment_state.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/repos/rep_shipment_details_repo_imp.dart';

class AcceptShipmentCubit extends Cubit<AcceptShipmentState> {
  final RepShipmentDetailsRepoImp repShipmentDetailsRepo;
  AcceptShipmentCubit({required this.repShipmentDetailsRepo})
    : super(AcceptRepShipmentInitial());
}

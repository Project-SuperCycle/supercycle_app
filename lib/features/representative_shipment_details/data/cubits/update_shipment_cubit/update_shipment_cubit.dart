import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/cubits/update_shipment_cubit/update_shipment_state.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/repos/rep_shipment_details_repo_imp.dart';

class UpdateShipmentCubit extends Cubit<UpdateShipmentState> {
  final RepShipmentDetailsRepoImp repShipmentDetailsRepo;
  UpdateShipmentCubit({required this.repShipmentDetailsRepo})
    : super(UpdateRepShipmentInitial());
}

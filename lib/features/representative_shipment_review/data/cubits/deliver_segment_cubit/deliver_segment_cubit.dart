import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/deliver_segment_cubit/deliver_segment_state.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/repos/rep_shipment_review_repo_imp.dart';

class DeliverSegmentCubit extends Cubit<DeliverSegmentState> {
  final RepShipmentReviewRepoImp repShipmentReviewRepo;
  DeliverSegmentCubit({required this.repShipmentReviewRepo})
    : super(DeliverSegmentInitial());
}

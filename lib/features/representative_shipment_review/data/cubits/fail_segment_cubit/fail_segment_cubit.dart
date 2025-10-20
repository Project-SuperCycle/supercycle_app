import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/fail_segment_cubit/fail_segment_state.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/repos/rep_shipment_review_repo_imp.dart';

class FailSegmentCubit extends Cubit<FailSegmentState> {
  final RepShipmentReviewRepoImp repShipmentReviewRepo;
  FailSegmentCubit({required this.repShipmentReviewRepo})
    : super(FailSegmentInitial());
}

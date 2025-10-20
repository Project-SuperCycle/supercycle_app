import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/start_segment_cubit/start_segment_state.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/repos/rep_shipment_review_repo_imp.dart';

class StartSegmentCubit extends Cubit<StartSegmentState> {
  final RepShipmentReviewRepoImp repShipmentReviewRepo;
  StartSegmentCubit({required this.repShipmentReviewRepo})
    : super(StartSegmentInitial());
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/weigh_segment_cubit/weigh_segment_state.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/repos/rep_shipment_review_repo_imp.dart';

class WeighSegmentCubit extends Cubit<WeighSegmentState> {
  final RepShipmentReviewRepoImp repShipmentReviewRepo;
  WeighSegmentCubit({required this.repShipmentReviewRepo})
    : super(WeighSegmentInitial());
}

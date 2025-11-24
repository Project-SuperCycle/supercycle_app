import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle/core/cubits/all_notes_cubit/all_notes_state.dart';
import 'package:supercycle/features/trader_shipment_details/data/repos/shipment_notes_repo_imp.dart';

class AllNotesCubit extends Cubit<AllNotesState> {
  final ShipmentNotesRepoImp shipmentNotesRepo;
  AllNotesCubit({required this.shipmentNotesRepo}) : super(AllNotesInitial());

  Future<void> getAllNotes({required String shipmentId}) async {
    emit(GetAllNotesLoading());
    try {
      var result = await shipmentNotesRepo.getAllNotes(shipmentId: shipmentId);
      result.fold(
        (failure) {
          emit(GetAllNotesFailure(errorMessage: failure.errMessage));
        },
        (notes) {
          emit(GetAllNotesSuccess(notes: notes));
          // Store user globally
        },
      );
      Logger().i("GET ALL NOTES CUBIT");
    } catch (error) {
      emit(GetAllNotesFailure(errorMessage: error.toString()));
    }
  }
}

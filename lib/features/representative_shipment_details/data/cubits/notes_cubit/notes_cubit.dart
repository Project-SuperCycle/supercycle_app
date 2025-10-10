import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/cubits/notes_cubit/notes_state.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/models/create_notes_model.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/repos/shipment_notes_repo_imp.dart';

class NotesCubit extends Cubit<NotesState> {
  final ShipmentNotesRepoImp shipmentNotesRepo;
  NotesCubit({required this.shipmentNotesRepo}) : super(NotesInitial());

  Future<void> addNotes({
    required CreateNotesModel notes,
    required String shipmentId,
  }) async {
    emit(AddNotesLoading());
    try {
      var result = await shipmentNotesRepo.addNotes(
        notes: notes,
        shipmentId: shipmentId,
      );
      result.fold(
        (failure) {
          emit(AddNotesFailure(errorMessage: failure.errMessage));
        },
        (message) {
          emit(AddNotesSuccess(message: message));
          // Store user globally
        },
      );
      Logger().i("ADD NOTES CUBIT");
    } catch (error) {
      emit(AddNotesFailure(errorMessage: error.toString()));
    }
  }

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

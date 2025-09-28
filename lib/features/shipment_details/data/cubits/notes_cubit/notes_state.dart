import 'package:equatable/equatable.dart';
import 'package:supercycle_app/features/shipment_details/data/models/notes_model.dart';

sealed class NotesState extends Equatable {
  const NotesState();
}

final class NotesInitial extends NotesState {
  @override
  List<Object> get props => [];
}

// GET ALL NOTES
final class GetAllNotesLoading extends NotesState {
  @override
  List<Object> get props => [];
}

final class GetAllNotesSuccess extends NotesState {
  final List<String> notes;
  const GetAllNotesSuccess({required this.notes});
  @override
  List<Object> get props => [];
}

final class GetAllNotesFailure extends NotesState {
  final String errorMessage;
  const GetAllNotesFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

// ADD NOTES
final class AddNotesLoading extends NotesState {
  @override
  List<Object> get props => [];
}

final class AddNotesSuccess extends NotesState {
  final String message;
  const AddNotesSuccess({required this.message});
  @override
  List<Object> get props => [];
}

final class AddNotesFailure extends NotesState {
  final String errorMessage;
  const AddNotesFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

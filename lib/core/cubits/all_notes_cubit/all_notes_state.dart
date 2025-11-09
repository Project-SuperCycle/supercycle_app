import 'package:equatable/equatable.dart';

sealed class AllNotesState extends Equatable {
  const AllNotesState();
}

final class AllNotesInitial extends AllNotesState {
  @override
  List<Object> get props => [];
}

// GET ALL NOTES
final class GetAllNotesLoading extends AllNotesState {
  @override
  List<Object> get props => [];
}

final class GetAllNotesSuccess extends AllNotesState {
  final List<String> notes;
  const GetAllNotesSuccess({required this.notes});
  @override
  List<Object> get props => [];
}

final class GetAllNotesFailure extends AllNotesState {
  final String errorMessage;
  const GetAllNotesFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

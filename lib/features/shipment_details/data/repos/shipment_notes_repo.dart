import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/features/shipment_details/data/models/create_notes_model.dart';
import 'package:supercycle_app/features/shipment_details/data/models/notes_model.dart';

abstract class ShipmentNotesRepo {
  Future<Either<Failure, String>> addNotes({
    required CreateNotesModel notes,
    required String shipmentId,
  });

  Future<Either<Failure, List<NotesModel>>> getAllNotes({
    required String shipmentId,
  });
}

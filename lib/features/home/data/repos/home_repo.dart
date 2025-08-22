import 'package:dartz/dartz.dart';
import 'package:supercycle_app/core/errors/failures.dart' show Failure;
import 'package:supercycle_app/features/home/data/models/dosh_data_model.dart'
    show DoshDataModel;
import 'package:supercycle_app/features/home/data/models/dosh_type_model.dart';
import 'package:supercycle_app/features/home/data/models/type_history_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<DoshTypeModel>>> fetchDoshTypes();

  Future<Either<Failure, List<TypeHistoryModel>>> fetchTypeHistory({
    required String typeId,
  });

  Future<Either<Failure, List<DoshDataModel>>> fetchTypesData();
}

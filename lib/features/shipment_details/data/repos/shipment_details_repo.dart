import 'package:dartz/dartz.dart';
import 'package:supercycle_app/core/errors/failures.dart' show Failure;
    show DoshDataModel;
import 'package:supercycle_app/features/home/data/models/dosh_type_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<DoshTypeModel>>> fetchDoshTypes();
}

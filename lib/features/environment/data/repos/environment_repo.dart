import 'package:dartz/dartz.dart';
import 'package:supercycle/core/errors/failures.dart';
import 'package:supercycle/features/environment/data/models/trader_eco_info_model.dart';

abstract class EnvironmentRepo {
  Future<Either<Failure, TraderEcoInfoModel>> getTraderEcoInfo();
}

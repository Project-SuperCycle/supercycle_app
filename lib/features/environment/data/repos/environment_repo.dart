import 'package:dartz/dartz.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/features/environment/data/models/trader_eco_info_model.dart';

abstract class EnvironmentRepo {
  Future<Either<Failure, TraderEcoInfoModel>> getTraderEcoInfo();
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle/core/errors/failures.dart';
import 'package:supercycle/core/models/single_shipment_model.dart';
import 'package:supercycle/core/services/api_endpoints.dart';
import 'package:supercycle/core/services/api_services.dart';
import 'package:supercycle/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle/features/shipments_calendar/data/repos/shipments_calendar_repo.dart';

class ShipmentsCalendarRepoImp implements ShipmentsCalendarRepo {
  final ApiServices apiServices;

  ShipmentsCalendarRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, List<ShipmentModel>>> getAllShipments({
    required Map<String, dynamic> query,
  }) async {
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getAllShipments,
        query: query,
      );

      // Log the response to debug
      Logger().d("API Response: $response");

      var data = response["data"];

      // Check if data is a Map (pagination structure) or List (direct array)
      List<dynamic> shipmentsData;

      if (data is Map<String, dynamic>) {
        // If it's a Map, look for common pagination keys
        if (data.containsKey('data')) {
          shipmentsData = data['data'] as List<dynamic>;
        } else if (data.containsKey('items')) {
          shipmentsData = data['items'] as List<dynamic>;
        } else if (data.containsKey('shipments')) {
          shipmentsData = data['shipments'] as List<dynamic>;
        } else {
          Logger().e("Unknown pagination structure: $data");
          return left(ServerFailure('Unknown response structure', 422));
        }
      } else if (data is List) {
        shipmentsData = data;
      } else {
        Logger().e("Unexpected data type: ${data.runtimeType}");
        return left(
          ServerFailure('Unexpected data type: ${data.runtimeType}', 422),
        );
      }

      List<ShipmentModel> shipments = [];
      for (var element in shipmentsData) {
        shipments.add(ShipmentModel.fromJson(element));
      }

      return right(shipments);
    } on DioException catch (dioError) {
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(ServerFailure(formatError.toString(), 422));
    } on TypeError catch (typeError, stackTrace) {
      Logger().w("typeError ${typeError.toString()}");
      Logger().w("stackTrace ${stackTrace.toString()}");
      return left(
        ServerFailure('Data parsing error: ${typeError.toString()}', 422),
      );
    } catch (e) {
      Logger().e("Unexpected error: ${e.toString()}");
      return left(
        ServerFailure('Unexpected error occurred: ${e.toString()}', 520),
      );
    }
  }

  @override
  Future<Either<Failure, List<ShipmentModel>>> getShipmentsHistory({
    required int page,
  }) async {
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getShipmentsHistory,
        query: {"page": page},
      );
      var data = response["result"]["data"];
      List<ShipmentModel> shipments = [];

      for (var element in data) {
        shipments.add(ShipmentModel.fromJson(element));
      }

      return right(shipments);
    } on DioException catch (dioError) {
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(ServerFailure(formatError.toString(), 422));
    } on TypeError catch (typeError, stackTrace) {
      Logger().w("typeError ${typeError.toString()}");
      Logger().w("stackTrace ${stackTrace.toString()}");
      return left(
        ServerFailure('Data parsing error: ${typeError.toString()}', 422),
      );
    } catch (e) {
      return left(
        ServerFailure('Unexpected error occurred: ${e.toString()}', 520),
      );
    }
  }

  @override
  Future<Either<Failure, List<ShipmentModel>>> getAllRepShipments({
    required Map<String, dynamic> query,
  }) async {
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getRepShipments,
        query: query,
      );

      // Log the response to debug
      Logger().d("API Response (Rep): $response");

      var data = response["data"];

      // Check if data is a Map (pagination structure) or List (direct array)
      List<dynamic> shipmentsData;

      if (data is Map<String, dynamic>) {
        // If it's a Map, look for common pagination keys
        if (data.containsKey('data')) {
          shipmentsData = data['data'] as List<dynamic>;
        } else if (data.containsKey('items')) {
          shipmentsData = data['items'] as List<dynamic>;
        } else if (data.containsKey('shipments')) {
          shipmentsData = data['shipments'] as List<dynamic>;
        } else {
          Logger().e("Unknown pagination structure: $data");
          return left(ServerFailure('Unknown response structure', 422));
        }
      } else if (data is List) {
        shipmentsData = data;
      } else {
        Logger().e("Unexpected data type: ${data.runtimeType}");
        return left(
          ServerFailure('Unexpected data type: ${data.runtimeType}', 422),
        );
      }

      List<ShipmentModel> shipments = [];
      for (var element in shipmentsData) {
        shipments.add(ShipmentModel.fromJson(element));
      }

      return right(shipments);
    } on DioException catch (dioError) {
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(ServerFailure(formatError.toString(), 422));
    } on TypeError catch (typeError) {
      return left(
        ServerFailure('Data parsing error: ${typeError.toString()}', 422),
      );
    } catch (e) {
      return left(
        ServerFailure('Unexpected error occurred: ${e.toString()}', 520),
      );
    }
  }

  @override
  Future<Either<Failure, SingleShipmentModel>> getShipmentById({
    required String shipmentId,
  }) async {
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getShipmentById.replaceFirst('{id}', shipmentId),
      );
      var data = response["data"];
      SingleShipmentModel shipment = SingleShipmentModel.fromJson(data);

      return right(shipment);
    } on DioException catch (dioError) {
      Logger().i("DioException ${dioError.toString()}");
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(ServerFailure(formatError.toString(), 422));
    } on TypeError catch (typeError) {
      Logger().e("ERROR REPO ${typeError.stackTrace}");
      return left(
        ServerFailure('Data parsing error: ${typeError.toString()}', 422),
      );
    } catch (e) {
      return left(
        ServerFailure('Unexpected error occurred: ${e.toString()}', 520),
      );
    }
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/functions/shipment_manager.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/deliver_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/fail_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/start_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/weigh_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/repos/rep_shipment_review_repo.dart';

class RepShipmentReviewRepoImp implements RepShipmentReviewRepo {
  final ApiServices apiServices;
  RepShipmentReviewRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> deliverSegment({
    required DeliverSegmentModel deliverModel,
  }) async {
    // TODO: implement deliverSegment
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.deliverShipmentSegment
            .replaceFirst('{shipmentId}', deliverModel.shipmentID)
            .replaceFirst('{segmentId}', deliverModel.segmentID),
        data: {},
      );
      String message = response["message"];
      return right(message);
    } on DioException catch (dioError) {
      Logger().i("DioException ${dioError.toString()}");
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(
        ServerFailure(
          formatError.toString(),
          422, // Unprocessable Entity
        ),
      );
    } on TypeError catch (typeError) {
      // أخطاء النوع (مثل null safety)
      return left(
        ServerFailure(
          'Data parsing error: ${typeError.toString()}',
          422, // Unprocessable Entity
        ),
      );
    } catch (e) {
      // أي أخطاء أخرى غير متوقعة
      return left(
        ServerFailure(
          'Unexpected error occurred: ${e.toString()}',
          520, // Unknown Error
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> failSegment({
    required FailSegmentModel failModel,
  }) async {
    // TODO: implement failSegment
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.failShipmentSegment
            .replaceFirst('{shipmentId}', failModel.shipmentID)
            .replaceFirst('{segmentId}', failModel.segmentID),
        data: {},
      );
      String message = response["message"];
      return right(message);
    } on DioException catch (dioError) {
      Logger().i("DioException ${dioError.toString()}");
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(
        ServerFailure(
          formatError.toString(),
          422, // Unprocessable Entity
        ),
      );
    } on TypeError catch (typeError) {
      // أخطاء النوع (مثل null safety)
      return left(
        ServerFailure(
          'Data parsing error: ${typeError.toString()}',
          422, // Unprocessable Entity
        ),
      );
    } catch (e) {
      // أي أخطاء أخرى غير متوقعة
      return left(
        ServerFailure(
          'Unexpected error occurred: ${e.toString()}',
          520, // Unknown Error
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> startSegment({
    required StartSegmentModel startModel,
  }) async {
    // TODO: implement startSegment
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.startShipmentSegment
            .replaceFirst('{shipmentId}', startModel.shipmentID)
            .replaceFirst('{segmentId}', startModel.segmentID),
        data: {},
      );
      String message = response["message"];
      return right(message);
    } on DioException catch (dioError) {
      Logger().i("DioException ${dioError.toString()}");
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(
        ServerFailure(
          formatError.toString(),
          422, // Unprocessable Entity
        ),
      );
    } on TypeError catch (typeError) {
      // أخطاء النوع (مثل null safety)
      return left(
        ServerFailure(
          'Data parsing error: ${typeError.toString()}',
          422, // Unprocessable Entity
        ),
      );
    } catch (e, stackTrace) {
      // أي أخطاء أخرى غير متوقعة
      Logger().e("START REPO $stackTrace");
      return left(
        ServerFailure(
          'Unexpected error occurred: ${e.toString()}',
          520, // Unknown Error
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> weighSegment({
    required WeighSegmentModel weighModel,
  }) async {
    // TODO: implement weighSegment
    try {
      FormData formData = await _weighFormData(weighModel: weighModel);

      final response = await apiServices.postFormData(
        endPoint: ApiEndpoints.weighShipmentSegment
            .replaceFirst('{shipmentId}', weighModel.shipmentID)
            .replaceFirst('{segmentId}', weighModel.segmentID),
        data: formData,
      );
      String message = response["message"];
      return right(message);
    } on DioException catch (dioError) {
      Logger().i("DioException ${dioError.toString()}");
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(
        ServerFailure(
          formatError.toString(),
          422, // Unprocessable Entity
        ),
      );
    } on TypeError catch (typeError) {
      // أخطاء النوع (مثل null safety)
      return left(
        ServerFailure(
          'Data parsing error: ${typeError.toString()}',
          422, // Unprocessable Entity
        ),
      );
    } catch (e) {
      // أي أخطاء أخرى غير متوقعة
      return left(
        ServerFailure(
          'Unexpected error occurred: ${e.toString()}',
          520, // Unknown Error
        ),
      );
    }
  }

  Future<FormData> _weighFormData({
    required WeighSegmentModel weighModel,
  }) async {
    List<File> images = weighModel.images;
    List<MultipartFile> imagesFiles =
        await ShipmentManager.createMultipartImages(images: images);

    // Create FormData
    final formData = FormData.fromMap({
      ...weighModel.toMap(),
      'images': imagesFiles, // Add the converted MultipartFiles
    });
    return formData;
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/functions/shipment_manager.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/models/accept_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/models/reject_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/models/update_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/repos/rep_shipment_details_repo.dart';

class RepShipmentDetailsRepoImp implements RepShipmentDetailsRepo {
  final ApiServices apiServices;
  RepShipmentDetailsRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> acceptShipment({
    required AcceptShipmentModel acceptModel,
  }) async {
    // TODO: implement acceptShipment
    try {
      FormData formData = await _acceptFormData(acceptModel: acceptModel);
      final response = await apiServices.postFormData(
        endPoint: ApiEndpoints.acceptRepShipment.replaceFirst(
          '{id}',
          acceptModel.shipmentID,
        ),
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

  @override
  Future<Either<Failure, String>> rejectShipment({
    required RejectShipmentModel rejectModel,
  }) async {
    // TODO: implement rejectShipment
    try {
      FormData formData = await _rejectFormData(rejectModel: rejectModel);
      final response = await apiServices.postFormData(
        endPoint: ApiEndpoints.rejectRepShipment.replaceFirst(
          '{id}',
          rejectModel.shipmentID,
        ),
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

  @override
  Future<Either<Failure, String>> updateShipment({
    required UpdateShipmentModel updateModel,
  }) async {
    // TODO: implement updateShipment
    try {
      FormData formData = await _updateFormData(updateModel: updateModel);

      final response = await apiServices.postFormData(
        endPoint: ApiEndpoints.updateRepShipment.replaceFirst(
          '{id}',
          updateModel.shipmentID,
        ),
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

  Future<FormData> _acceptFormData({
    required AcceptShipmentModel acceptModel,
  }) async {
    List<File> images = acceptModel.images;
    List<MultipartFile> imagesFiles =
        await ShipmentManager.createMultipartImages(images: images);

    // Create FormData
    final formData = FormData.fromMap({
      ...acceptModel.toMap(),
      'images': imagesFiles, // Add the converted MultipartFiles
    });
    return formData;
  }

  Future<FormData> _rejectFormData({
    required RejectShipmentModel rejectModel,
  }) async {
    List<File> images = rejectModel.images;
    List<MultipartFile> imagesFiles =
        await ShipmentManager.createMultipartImages(images: images);

    // Create FormData
    final formData = FormData.fromMap({
      ...rejectModel.toMap(),
      'images': imagesFiles, // Add the converted MultipartFiles
    });
    return formData;
  }

  Future<FormData> _updateFormData({
    required UpdateShipmentModel updateModel,
  }) async {
    List<File> images = updateModel.images;
    List<MultipartFile> imagesFiles =
        await ShipmentManager.createMultipartImages(images: images);

    // Create FormData
    final formData = FormData.fromMap({
      ...updateModel.toMap(),
      'images': imagesFiles, // Add the converted MultipartFiles
    });
    return formData;
  }
}

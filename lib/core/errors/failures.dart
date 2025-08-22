import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout. Please check your internet.');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Request timeout. Please try again.');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          'Server is taking too long to respond. Try again.',
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure('Request was canceled.');

      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
        return _handleConnectionError(dioError);
      default:
        return ServerFailure('Unexpected error occurred. Please try again.');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (response is Map<String, dynamic>) {
      final errorMessage = response['message'] ?? 'Unknown error';
      switch (statusCode) {
        case 400:
        case 401:
        case 403:
          return ServerFailure(errorMessage);
        case 404:
          return ServerFailure(errorMessage);
        case 409:
          return ServerFailure(errorMessage);
        case 500:
          return ServerFailure('Server error. Please try later.');
        default:
          return ServerFailure('Unexpected server error. Try again.');
      }
    }
    return ServerFailure('Unexpected response format.');
  }

  static ServerFailure _handleConnectionError(DioException dioError) {
    final errorMessage = dioError.message?.toLowerCase() ?? '';
    if (errorMessage.contains('socket exception')) {
      return ServerFailure('No Internet Connection.');
    }
    return ServerFailure(
      'Network error occurred. Please check your connection.',
    );
  }
}

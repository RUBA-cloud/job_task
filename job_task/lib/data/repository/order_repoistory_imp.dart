import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/api_service/api_service.dart';
import 'package:job_task/data/model/request/order/create_order_request.dart';
import 'package:job_task/data/model/response/create_order_entity.dart';
import 'package:job_task/domain/repository/order_repository.dart';

@Injectable(as: OrderRepository)
class OrderRepositoryImp implements OrderRepository {
  final ApiService _apiService;

  // ============================================================
  // CONSTRUCTOR
  // ============================================================

  OrderRepositoryImp(this._apiService);

  // ============================================================
  // CREATE ORDER
  // ============================================================

  @override
  Future<ApiResult<CreateOrderEntity>> createOrder(
      CreateOrderRequest request,
      ) async {
    try {
      final res = await _apiService.makeOrder(
        request,
      );

      return Success(
        data: res,
      );
    } on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }

  }
}
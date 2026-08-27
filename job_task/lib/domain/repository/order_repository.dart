import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/order/create_order_request.dart';
import 'package:job_task/data/model/response/create_order_entity.dart';

abstract class OrderRepository {
  Future<ApiResult<CreateOrderEntity>> createOrder(
      CreateOrderRequest request,
      );
}
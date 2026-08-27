import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/order/create_order_request.dart';
import 'package:job_task/data/model/response/create_order_entity.dart';
import 'package:job_task/domain/repository/order_repository.dart';

@singleton
class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(
      this.repository,
      );

  Future<ApiResult<CreateOrderEntity>> execute(
      CreateOrderRequest request,
      ) {
    return repository.createOrder(
      request,
    );
  }
}